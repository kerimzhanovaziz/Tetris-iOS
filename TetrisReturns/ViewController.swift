//
//  ViewController.swift
//  TetrisReturns
//
//  Created by Daniil Orlov on 4/6/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var gameAreaView: GameAreaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func generateButtonTap(_ sender: UIButton) {
        
        self.gameAreaView.generateRandomGame()
    }
}

