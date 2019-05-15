//
//  DataManager.swift
//  TetrisReturns
//
//  Created by ITLabAdmin on 5/14/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import Foundation

class DataManager {
    
    class var shared: DataManager {
        struct Static {
            static let instance = DataManager()
        }
        return Static.instance
    }
 
    private let highScore = "highScore"
    private let scoreKey = "score"
 
    func addHighScore(score: [Int]) {
//        var ar = score
//        ar.sorted().reversed()
        UserDefaults.standard.set(Array(score.sorted().reversed()), forKey: highScore)
    }
    
    func getHighScores() -> [Int] {
        if let ar = UserDefaults.standard.array(forKey: highScore) as? [Int] {
            return ar
        }
        return []
    }
    
    func addScore(score: Int) {
        UserDefaults.standard.set(score, forKey: scoreKey)
    }
    
    func getScore() -> Int {
        return UserDefaults.standard.integer(forKey: scoreKey)
    }
}
