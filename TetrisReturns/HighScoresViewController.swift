//
//  HighScoresViewController.swift
//  TetrisReturns
//
//  Created by ITLabAdmin on 5/3/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import UIKit

class HighScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var highScores: [Int] = []
    var names = ["John" , "Aziz" , "Doni" , "Maka"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        highScores = DataManager.shared.getHighScores()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath) as! HighScoreTableViewCell
        cell.highScoreLabel.text = "\(highScores[indexPath.row])"
        cell.namesLabel.text = names[Int(arc4random_uniform(UInt32(names.count - 1)))]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
