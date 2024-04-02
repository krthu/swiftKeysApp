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
    
    func showAlert() {
        // Skapa en alert controller med titel och meddelande
        let alertController = UIAlertController(title: "Ange spelarnamn", message: "Du måste ange ett namn för att kunna spela", preferredStyle: .alert)

        // Skapa en åtgärd för alert kontrollern
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
     
        }

        // Lägg till åtgärden till alert kontrollern
        alertController.addAction(okAction)

        // Presentera alert kontrollern
        self.present(alertController, animated: true, completion: nil)
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
            if !name.isEmpty {
                gameManager.setActivePlayer(player: Player(name: name, score: 0))
                performSegue(withIdentifier: gameSegueKey, sender: self)
            }
            else {
                showAlert()
            }
        }
    }
    
}

