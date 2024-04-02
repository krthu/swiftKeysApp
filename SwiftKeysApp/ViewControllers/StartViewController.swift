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
    var gameManager = GameManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.   
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == gameSegueKey{

            let difficulty = levelSelector.selectedSegmentIndex
            gameManager.setDifficulty(level: difficulty)
            
            let destinationVC = segue.destination as? GameViewController
            destinationVC?.gameManager = gameManager
        }
    }

    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        let name = playerNameField.text
        
        if let name = name {
            gameManager.setActivePlayer(player: Player(name: name, score: 0))
        }
        
    }
    
}

