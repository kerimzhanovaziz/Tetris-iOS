//
//  Conf.swift
//  TetrisReturns
//
//  Created by ITLabAdmin on 5/14/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import UIKit

class Conf {
    
    static let fontName = "RobotoSlab-Regular"
    static let fontColor = UIColor(red: 203, green: 80, blue: 101)
    static let fontDisabledColor = UIColor(red: 135, green: 147, blue: 114)
    
    static let backgroundColor      = UIColor(red: 59, green: 56, blue: 60)
    static let blockBackgroundColor = UIColor.black
    static let blockColor           = UIColor(red: 106, green: 165, blue: 235)
    static let groundColor          = UIColor(red: 106, green: 165, blue: 235)
    static let playAreaBorderColor  = UIColor(red: 106, green: 165, blue: 235)
    static let disabledColor        = UIColor(red: 106, green: 165, blue: 235)
    static let enabledColor         = UIColor.black
    
    static let blockGapM          = CGFloat(2)
    static let blockBorderM       = CGFloat(1)
    static let blockInnerGapM     = CGFloat(1)
    static let blockInnerBlockM   = CGFloat(6)
    static var blockM: CGFloat {
        return 2 * (blockBorderM + blockInnerGapM) + blockInnerBlockM
    }
    
    static let margin = CGFloat(3)
    
    static let playAreaWidthScale = CGFloat(0.6)
    static let playAreaBorderM    = CGFloat(1)
    static let playAreaBlockCols  = 12
    static let playAreaBlockRows  = 22
    //static func getPlayAreaWidthM(cols: Int) -> CGFloat {
    //    return 2 * playAreaBorderM + CGFloat(cols) * (blockM + blockGapM) + blockGapM
    //}
    
    static let nextPieceBlockRows = 2
    static let nextPieceBlockCols = 4
    static func getWidthM() -> CGFloat {
        let playAreaWidthM = 2 * playAreaBorderM + CGFloat(playAreaBlockCols) * (blockM + blockGapM) + blockGapM
        let infoAreaWidthM = CGFloat(nextPieceBlockCols) * (blockM + blockGapM) + blockGapM
        let playAreaAndInfoAreaGapM = CGFloat(1)
        return playAreaWidthM + infoAreaWidthM + playAreaAndInfoAreaGapM
    }
}
