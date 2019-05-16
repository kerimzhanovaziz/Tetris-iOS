//
//  ViewController.swift
//  TetrisReturns
//
//  Created by Daniil Orlov on 4/6/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        startAudio()
        
        let v = self.view as! SKView
        v.ignoresSiblingOrder = true
        let scene = GameScene(size: v.bounds.size)
        scene.scaleMode = .aspectFill
        
        v.presentScene(scene)
    }
    
    func startAudio() {
        let filePath = Bundle.main.path(forResource: "POL-net-bots-short", ofType: "wav")
        let fileURL = NSURL.fileURL(withPath: filePath!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL, fileTypeHint: AVFileTypeMPEGLayer3)
            audioPlayer.numberOfLoops = -1
            audioPlayer.volume = 1
        } catch {
            self.present(UIAlertController.init(title: "Error", message: "Error Message", preferredStyle: .alert), animated: true, completion: nil)
        }
        audioPlayer.play()
    }
}

