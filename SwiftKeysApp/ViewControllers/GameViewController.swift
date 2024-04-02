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
    @objc func countDownTimer(_ timer: Timer? = nil) {
        seconds -= 1

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.seconds >= 0 {
                self.timerLabel.text = String(self.seconds)
                self.updateProgressBar()
            } else {
                self.timer?.invalidate()
                // Hantera vad som händer när tiden löper ut, exempelvis visa ett meddelande eller ladda ett nytt ord
            }
        }
    }
    func getNewWord(){
        guard let gameManager = gameManager else { return }
                wordLabel.text = gameManager.getRandomWord()
                seconds = 5
                timer?.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
                updateProgressBar()
            }

    func updateProgressBar() {
            let totalSeconds = 5.0
            let progress = Float(seconds) / Float(totalSeconds)
            DispatchQueue.main.async { [weak self] in
                self?.progressBar.setProgress(progress, animated: true)
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
    
    @objc func countDownTimerWrapper() {
        countDownTimer()
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
