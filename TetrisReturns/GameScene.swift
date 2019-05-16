//
//  GameScene.swift
//  TetrisReturns
//
//  Created by ITLabAdmin on 5/14/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import SpriteKit
import GameplayKit
import os.log

enum GameState {
    case idle
    case running
    case paused
}

class GameScene: SKScene {
    
    let loadSndEffects = true
    var soundEffectActions: [String: SKAction]!
    
    var state: GameState = .idle
    var mute = false
    
    var playArea: PlayArea!
    var ctrlArea: ControlArea!
    var infoArea: InfoArea!
    var gameData = GameData()
    var mainView = UIView()
    
    override func didMove(to view: SKView) {
        
        if loadSndEffects && soundEffectActions == nil {
            soundEffectActions = [
                "move":   SKAction.playSoundFileNamed("move.wav",   waitForCompletion: false),
                "land":   SKAction.playSoundFileNamed("land.wav",   waitForCompletion: true),
                "rotate": SKAction.playSoundFileNamed("rotate.wav", waitForCompletion: false),
                "clear":  SKAction.playSoundFileNamed("clear.wav",  waitForCompletion: false),
                "over":   SKAction.playSoundFileNamed("over.wav",   waitForCompletion: false)
            ]
        } else {
            soundEffectActions = [String: SKAction]()
        }
        
        // customization
        self.backgroundColor = Conf.backgroundColor
        self.isUserInteractionEnabled = false
        
        let widthUnit = (self.size.width - 3 * Conf.margin) / Conf.getWidthM()
        //os_log("scene size width=%f, width unit=%f", type: .debug, self.size.width, widthUnit)
        //os_log("play area width-m=%f", type: .debug, Conf.getPlayAreaWidthM(cols: 10))
        //os_log("full area widht-m=%f", type: .debug, Conf.getWidthM())
        //os_log("scene frame width=%f", type: .debug, self.frame.width)
        let blockBorder = widthUnit * Conf.blockBorderM
        let blockInnerGap = widthUnit * Conf.blockInnerGapM
        let blockInnerBlock = widthUnit * Conf.blockInnerBlockM
        let block = Block(border: blockBorder, gap: blockInnerGap, size: blockInnerBlock)
        
        // play area
        let playArea = PlayArea()
        playArea.setup(scene: self, block: block, unit: widthUnit)
        
        let ctrlAreaRect = CGRect(
            x: Conf.margin,
            y: Conf.margin,
            width: self.size.width - 2 * Conf.margin,
            height: self.size.height - playArea.size.height - 2 * Conf.margin)
        
        // control area
        let ctrlArea = ControlArea()
        ctrlArea.setup(scene: self,
                       playAreaWidth: playArea.size.width,
                       rect: ctrlAreaRect)
        
        // info area
        let infoAreaRect = CGRect(
            x: playArea.size.width + 2 * Conf.margin,
            y: playArea.position.y + widthUnit * Conf.playAreaBorderM + widthUnit * Conf.blockGapM,
            width: ctrlAreaRect.width - playArea.size.width - Conf.margin,
            height: playArea.size.height - 2 * widthUnit * (Conf.playAreaBorderM + Conf.blockGapM)
        )
        //os_log("info area x=%f, y=%f, width=%f, height=%f", type: .debug, infoAreaRect.origin.x, infoAreaRect.origin.y, infoAreaRect.size.width, infoAreaRect.size.height)
        let infoArea = InfoArea(block: block, unit: widthUnit)
        infoArea.setup(scene: self, rect: infoAreaRect, data: playArea.field.gameData)
        
        self.playArea = playArea
        self.ctrlArea = ctrlArea
        self.infoArea = infoArea
        
    }
    
    func playSoundEffect(_ name: String) {
        if loadSndEffects && !self.mute {
            if let sndEffectAction = self.soundEffectActions[name] {
                self.run(sndEffectAction)
            }
        }
    }
    
    func playAreaTouched() {
        switch self.state {
        case .idle:
            self.newGame()
        case .running:
            self.pauseGame()
        case .paused:
            self.unpauseGame()
        }
    }
    
    func unpauseGame() {
        self.state = .running
        self.ctrlArea.enable()
        self.playArea.unpause()
        self.infoArea.unpause()
    }
    
    func pauseGame() {
        self.state = .paused
        self.ctrlArea.disable()
        self.playArea.pause()
        self.infoArea.pause()
        showGameOver()
    }
    
    func showGameOver() {
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: (self.view?.frame.width)!, height: (self.view?.frame.height)!))
        mainView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let insideView = UIView(frame: CGRect(x: (mainView.frame.width - (mainView.frame.width - 128)) / 2, y: (mainView.frame.height - (mainView.frame.height - 256)) / 2, width: (mainView.frame.width - 128), height: (mainView.frame.height - 256)))
        insideView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let resumeButton = UIButton(frame: CGRect(x: 0, y: 0, width: insideView.frame.width, height: insideView.frame.height / 2))
        resumeButton.backgroundColor = .white
        resumeButton.addTarget(self, action: #selector(resumeButtonClicked), for: .touchUpInside)
        resumeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        resumeButton.setTitle("RESUME", for: .normal)
        resumeButton.setTitleColor(.black, for: .normal)
        
        let quitButton = UIButton(frame: CGRect(x: 0, y: insideView.frame.height / 2 + 1, width: insideView.frame.width, height: insideView.frame.height / 2))
        quitButton.backgroundColor = .white
        quitButton.addTarget(self, action: #selector(quitButtonClicked), for: .touchUpInside)
        quitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        quitButton.setTitle("QUIT", for: .normal)
        quitButton.setTitleColor(.black, for: .normal)
        
        insideView.addSubview(resumeButton)
        insideView.addSubview(quitButton)
        
        mainView.addSubview(insideView)
        self.view?.addSubview(mainView)
    }
    
    @objc private func resumeButtonClicked() {
        unpauseGame()
        mainView.removeFromSuperview()
    }
    
    @objc private func quitButtonClicked() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "main")
        vc.view.frame = (self.view?.frame)!
        vc.view.layoutIfNeeded()
       
        UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.view?.window?.rootViewController = vc
        }, completion: { completed in
        })
    }
    
    func newGame() {
        self.state = .running
        self.ctrlArea.enable()
        self.playArea.newGame()
        self.infoArea.newGame()
    }
    
    func reset() {
        var ar = DataManager.shared.getHighScores()
        ar.append(DataManager.shared.getScore())
        DataManager.shared.addHighScore(score: ar)
        self.state = .idle
        self.ctrlArea.disable()
        self.playArea.reset()
        self.infoArea.reset()
    }
    
    func toggleSpeaker() {
        self.mute = !self.mute
        self.infoArea.updateSpeaker(mute: self.mute)
    }
    
    func changeGameSpeed() {
        self.playArea.field.changeGameSpeed()
    }
    
    func movePieceLeft(_ start: Bool) { self.playArea.field.moveLeft(start) }
    func movePieceRight(_ start: Bool) { self.playArea.field.moveRight(start) }
    func movePieceDown(_ start: Bool) { self.playArea.field.moveDown(start) }
    func rotatePiece() { self.playArea.field.rotate() }
    func dropPiece() { self.playArea.drop() }
    
    func updateNextPiece(_ piece: Piece?) { self.infoArea.updateNextPiece(piece) }
    func updateInfoArea(_ data: GameData) { self.infoArea.updateGameData(data) }
}

