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
            userInputField.text = "" //empty input field
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

                // Skapa en fördröjning och kör kodblocket efter den angivna tiden
                DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                    self.getNewWord()
                }
                
                
            }
        }
    }

    func animateWordIntoScore(){
        
        guard let wordLabel = animatedLabelToPoints, let scoreLabel = scoreLabel else { return }

        // Ta reda på slutpositionen baserat på poänglabelns position
        let endPosition = scoreLabel.center

        // Spara ursprungsläget för att återställa det senare
        let startPosition = wordLabel.center
        
        // Sätt alpha till 0.0 för att börja med
        wordLabel.alpha = 0.0
          
        // Animationskedja
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
            
            // Första keyframe: Förstora ordet och börja visa det gradvis
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                wordLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                wordLabel.alpha = 0.2 // Börja göra ordet synligt
            }
            

            // Andra keyframe: Förflytta och minska ordet, öka alpha till 1
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.7) {
                
                wordLabel.center = endPosition
                wordLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                wordLabel.alpha = 1.0 // Gör ordet helt synligt mot slutet av animationen
            }

        }) { _ in
            // Återställ ordets position och storlek för nästa gång det används
            wordLabel.center = startPosition
            wordLabel.transform = .identity
            wordLabel.alpha = 0 // Antagligen vill du sätta detta till 1.0 om ordet ska vara synligt efter återställningen
        }
    }
    
    func animateLosingScore(){
        
        guard let wordLabel = animateLosingPoints, let scoreLabel = scoreLabel else { return }

        // Ta reda på slutpositionen baserat på poänglabelns position
        var endPosition = wordLabel.center
        endPosition.y += 200

        // Spara ursprungsläget för att återställa det senare
        let startPosition = scoreLabel.center
        
        // Sätt alpha till 0.0 för att börja med
        wordLabel.alpha = 0.0
          
        // Animationskedja
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
            
            // Första keyframe: Förstora ordet och börja visa det gradvis
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                wordLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                wordLabel.alpha = 0.2 // Börja göra ordet synligt
            }
            

            // Andra keyframe: Förflytta och minska ordet, öka alpha till 1
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.7) {
                
                wordLabel.center = endPosition
                wordLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                wordLabel.alpha = 1.0 // Gör ordet helt synligt mot slutet av animationen
            }

        }) { _ in
            // Återställ ordets position och storlek för nästa gång det används
            wordLabel.center = startPosition
            wordLabel.transform = .identity
            wordLabel.alpha = 0 // Antagligen vill du sätta detta till 1.0 om ordet ska vara synligt efter återställningen
        }
    }

    
    func changeBackground(toThisColor : UIColor){

        // Sätt den initiala bakgrundsfärgen
        self.view.backgroundColor = .white

        // Använd UIView.animate för att skapa en animation
        UIView.animate(withDuration: 0.05, animations: {
            // Ändra bakgrundsfärgen till en ny färg
            self.view.backgroundColor = toThisColor
        }) { (finished) in
            // Efter att animationen är klar, vänta 1 sekund innan du ändrar tillbaka färgen
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                UIView.animate(withDuration: 0.05) {
                    // Ändra tillbaka till den ursprungliga färgen eller till en annan färg
                    self.view.backgroundColor = .white
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
