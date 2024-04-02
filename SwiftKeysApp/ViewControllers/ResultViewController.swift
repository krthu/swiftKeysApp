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
        // Do any additional setup after loading the view.
    }
    

    
        @IBAction func donePressed(_ sender: Any) {
            if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                navigationController.popToRootViewController(animated: true)
            }
            
            
        }
        
//    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: "rewindToGame", sender: self)
//    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
