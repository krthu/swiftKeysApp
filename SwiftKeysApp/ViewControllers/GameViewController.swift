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
//    var timer = Timer.scheduledTimer(timeInterval: 0.1, target: GameViewController.self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
    var seconds: Double = 0
    
    var secondsPerWord: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameManager?.resetGame()
        setTimer()
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

    
    @objc func countDownTimer(_ timer: Timer? = nil) {
        seconds -= 0.1 // Minskar med 0.1 varje tick istället för 1
        
        if self.seconds > 0 {
            self.timerLabel.text = String(format: "%.1f", self.seconds) // Uppdaterar label med en decimal
            self.updateProgressBar()
            
        } else {
            self.seconds = 0 // Säkerställ att seconds inte går under 0
            gameManager?.addScore(scoreToAdd: -1)
            if let score = gameManager?.getScore(){
                scoreLabel.text = String(score)
            }
            
            getNewWord()
        }
    }
    func updateProgressBar() {
        let progress = Float(seconds) / Float(secondsPerWord)
        DispatchQueue.main.async { [weak self] in
            self?.progressBar.setProgress(progress, animated: false)
        }
    }

    
    func getNewWord(){
        guard let gameManager = gameManager else { return }
        let newWord = gameManager.getRandomWord()
        if newWord != nil{
            wordLabel.text = newWord
            seconds = secondsPerWord
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
            updateProgressBar()
        } else{
            self.timer?.invalidate()
            performSegue(withIdentifier: resultSegueKey, sender: self)
        }
        
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
    func setTimer() {
        let diff = gameManager?.getDifficulty()
        
        if diff == 2 {
            secondsPerWord = 3
        }
        else if diff == 1 {
            secondsPerWord = 4
        }
        else {
            secondsPerWord = 5
        }
    }
    
    @objc func countDownTimerWrapper() {
        countDownTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == resultSegueKey{
            let destinationVC = segue.destination as? ResultViewController
            destinationVC?.player = gameManager?.getActivePlayer()
            
            
        }
    }
    
    @IBAction func unwindResultsViewController(_ segue: UIStoryboardSegue) {
        gameManager?.resetGame()
        setUpNewGame()
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
