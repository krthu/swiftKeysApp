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
    
    @IBOutlet weak var animatedLabelToPoints: UILabel!
    
    @IBOutlet weak var animateLosingPoints: UILabel!
    
    var resultSegueKey = "resultSegue"
    
    var gameManager: GameManager?
    
    
    var timer : Timer?
    var seconds: Double = 0
    
    var secondsPerWord: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameManager?.resetGame()
        setTimer()
        setUpNewGame()
        userInputField.becomeFirstResponder()
        userInputField.delegate = self
        
    }
    
    func setUpNewGame(){
        if let score = gameManager?.getScore(){
            scoreLabel.text = "\(score)"
        }
        userInputField.text = ""
        
        getNewWord()
        
    }

    
    @objc func countDownTimer(_ timer: Timer? = nil) {
        seconds -= 0.1
        
        if self.seconds > 0 {
            self.timerLabel.text = String(format: "%.1f", self.seconds)
            self.updateProgressBar()
            
        } else {
            self.seconds = 0
            userInputField.text = ""
            gameManager?.addOrDecreaseScore(isRight: false)
            changeBackground(toThisColor: .red)
            if let score = gameManager?.getScore(){
                scoreLabel.text = String(score)
            }
            
            animateLosingScore()
            
            getNewWord()
        }
    }
    
    
    func updateProgressBar() {
        let progress = Float(seconds) / Float(secondsPerWord)
        if progress >= 0.6 {
                    progressBar.tintColor = .green
                } else if progress < 0.6 && progress >= 0.3{
                    progressBar.tintColor = .yellow
                } else{
                    progressBar.tintColor = .red
                }
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
                changeBackground(toThisColor: .green)
                userInputField.text = ""
                animatedLabelToPoints.text = wordLabel.text
                
                animateWordIntoScore()
                
                let delayInSeconds = 0.5
               
                DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                    self.getNewWord()
                }
                
                
            }
        }
    }

    func animateWordIntoScore(){
        
        guard let wordLabel = animatedLabelToPoints, let scoreLabel = scoreLabel else { return }

  
        // Get end position for animation based on scorelabels position
        let endPosition = scoreLabel.center

      
        // Save start position
        let startPosition = wordLabel.center
        
        wordLabel.alpha = 0.0
          
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
       
            // First keyframe: enlarge word and gradually show it
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                wordLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                wordLabel.alpha = 0.2 // Börja göra ordet synligt
            }
            

        
            // Secondframe: Move and shrink the word and make it more visible
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.7) {
                
                wordLabel.center = endPosition
                wordLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                wordLabel.alpha = 1.0
            }

        }) { _ in
            
            wordLabel.center = startPosition
            wordLabel.transform = .identity
            wordLabel.alpha = 0
        }
    }
    
    func animateLosingScore(){
        
        guard let wordLabel = animateLosingPoints, let scoreLabel = scoreLabel else { return }

        
        var endPosition = wordLabel.center
        endPosition.y += 200


        let startPosition = scoreLabel.center
        
   
        wordLabel.alpha = 0.0
          
    
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
            
          
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                wordLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                wordLabel.alpha = 0.2
            }
            

          
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.7) {
                
                wordLabel.center = endPosition
                wordLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                wordLabel.alpha = 1.0
            }

        }) { _ in
        
            wordLabel.center = startPosition
            wordLabel.transform = .identity
            wordLabel.alpha = 0
        }
    }

    
    func changeBackground(toThisColor : UIColor){

     
        self.view.backgroundColor =  UIColor.systemBackground

        
        UIView.animate(withDuration: 0.05, animations: {
         
            self.view.backgroundColor = toThisColor
        }) { (finished) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                UIView.animate(withDuration: 0.05) {
               
                    self.view.backgroundColor =  UIColor.systemBackground
                }
            }
        }

    }
    func setTimer() {
        let diff = gameManager?.getDifficulty()
        
        if diff == 2 {
            secondsPerWord = 5
            gameManager?.setPointsPerWord(to: 3)
            animateLosingPoints.text = "-3"
        }
        else if diff == 1 {
            secondsPerWord = 7
            gameManager?.setPointsPerWord(to: 2)
            animateLosingPoints.text = "-2"
        }
        else {
            secondsPerWord = 10
            gameManager?.setPointsPerWord(to: 1)
            animateLosingPoints.text = "-1"
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
            timer?.invalidate()
            timer = nil
            super.viewWillDisappear(animated)
    }

    
}
