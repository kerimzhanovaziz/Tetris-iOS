//
//  HighScoreTableViewCell.swift
//  TetrisReturns
//
//  Created by ITLabAdmin on 5/14/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
