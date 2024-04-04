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
        addDoneButtonOnKeyboard(to: playerNameField)
    
    }

    func addDoneButtonOnKeyboard(to textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneClicked))

        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
    }

    @objc func doneClicked() {
        //make keyboard invisible
        view.endEditing(true)
    }
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Ange spelarnamn", message: "Du måste ange ett namn för att kunna spela", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
       
        alertController.addAction(okAction)
        
        
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

