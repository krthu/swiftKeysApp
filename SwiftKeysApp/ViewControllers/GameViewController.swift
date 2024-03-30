//
//  GameViewController.swift
//  SwiftKeysApp
//
//  Created by Mattias Axelsson on 2024-03-28.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var userInputField: UITextField!
    
    var resultSegueKey = "resultSegue"
    
    var gameManager: GameManager?
    
    
    var timer : Timer?
    var seconds = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNewGame()
        userInputField.becomeFirstResponder()
        userInputField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func setUpNewGame(){
        if let score = gameManager?.getScore(){
            scoreLabel.text = "\(score)"
        }
        userInputField.text = ""
        
        getNewWord()
        
        
    }
    func countDownTimer(timer : Timer? = nil){
        seconds -= 1
    
        if(seconds>=0){
        var secondsString = String(seconds)
            timerLabel.text = secondsString
            print("\(secondsString)")
        }else{
            timer?.invalidate()
        }
    }
    
    func getNewWord(){
        guard let gameManager = gameManager else{ return }
        wordLabel.text = gameManager.getRandomWord()
        seconds = 5
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: countDownTimer(timer:))
        print("newWord")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let word = userInputField.text,
           let gameManager = gameManager{
            if gameManager.correctSpelled(word: word){
                if let score = gameManager.getScore(){
                    scoreLabel.text = "\(score)"
                }
                userInputField.text = ""
                getNewWord()
               
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
