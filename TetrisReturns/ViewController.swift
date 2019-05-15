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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = self.view as! SKView
        v.ignoresSiblingOrder = true
        let scene = GameScene(size: v.bounds.size)
        scene.scaleMode = .aspectFill
        
        v.presentScene(scene)
    }
}

