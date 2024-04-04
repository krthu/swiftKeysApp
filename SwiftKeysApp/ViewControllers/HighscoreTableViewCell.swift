//
//  HighscoreTableViewCell.swift
//  SwiftKeysApp
//
//  Created by Mattias Axelsson on 2024-03-28.
//

import UIKit

class HighscoreTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
