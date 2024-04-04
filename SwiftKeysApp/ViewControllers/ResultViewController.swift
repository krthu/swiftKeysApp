//
//  ResultViewController.swift
//  SwiftKeysApp
//
//  Created by Mattias Axelsson on 2024-03-28.
//

import UIKit

class ResultViewController: UIViewController {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    var player: Player?
    var highScoreManager = HighScoreManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = player?.name
        if let score = player?.score{
            finalScoreLabel.text = "\(score)p"
        }
        
        highScoreManager.loadListFromUserDefaults()
        if let player = player{
            highScoreManager.addPlayer(playerToAdd: player)
        }
        highScoreManager.saveListToUserDefaults()
        print(highScoreManager.getList())
        
    }
    

    
        @IBAction func donePressed(_ sender: Any) {
            if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                navigationController.popToRootViewController(animated: true)
            }
            
            
        }
        
}
