//
//  ViewController.swift
//  SwiftKeysApp
//
//  Created by Kristian Thun on 2024-03-28.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var levelSelector: UISegmentedControl!
    
    @IBOutlet weak var playerNameField: UITextField!
    
    var highscoreSegueKey = "highscoreSegue"
    var gameSegueKey = "gameSegue"
    var gameManager = GameManger()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.   
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == gameSegueKey{
            //Vi behöver nog ha en action från knappen spela för att ta användarens namn och göra en player
            let name = playerNameField.text
            if let name = name {
                gameManager.setActivePlayer(player: Player(name: name, score: 0))
            }
            // Allt mellan det här skulle vi nog lägga i den actionen
            
            let destinationVC = segue.destination as? GameViewController
            destinationVC?.gameManager = gameManager
        }
    }


}

