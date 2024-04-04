//
//  GameManager.swift
//  SwiftKeysApp
//
//  Created by Kristian Thun on 2024-03-28.
//


import Foundation

class GameManager{
    
    private var wordToType: String?
    
    private var activePlayer: Player?
    private var pointsPerWord = 1
    private var wordsInGame: Int = 10
    private var wordsDone: Int = 0
    private var difficulty: Int = 0
    private var wordGenerator = WordGenerator()
    
    
    
    func getRandomWord() -> String? {
        if wordsDone == wordsInGame {
            return nil
        }
        
        let percentDone = Double (wordsDone) / Double (wordsInGame)
        
        wordToType =  if percentDone >= 0.8 {
             wordGenerator.generateWord(difficulty: .hard)
        } else if percentDone >= 0.5 && percentDone < 0.8 {
             wordGenerator.generateWord(difficulty: .medium)
        } else {
             wordGenerator.generateWord(difficulty: .easy)
        }
        wordsDone += 1
        
    
        return wordToType
    }
    
    
    
    func correctSpelled(word: String) -> Bool{
        if word.lowercased() == wordToType?.lowercased() {
            // activePlayer?.changeScore(with: pointsPerWord)
            addOrDecreaseScore(isRight: true)
            return true
        }
        
        return false
    }
    
    func addOrDecreaseScore(isRight: Bool){
        if isRight {
            activePlayer?.changeScore(with: pointsPerWord)
        } else {
            activePlayer?.changeScore(with: -pointsPerWord)
        }
        
        
    }
    
    func getScore() -> Int?{
        if let activePlayer = activePlayer{
            return activePlayer.score
        }
        return nil
    }
    
    func getActivePlayerName() -> String?{
        return activePlayer?.name
    }
    
    func setActivePlayer(player: Player){
        activePlayer = player
    }
    
    func resetGame(){
        activePlayer?.score = 0
        wordsDone = 0
        wordToType = nil
    }
    
    
    func getActivePlayer() -> Player?{
        return activePlayer
    }
    
    func setDifficulty(level: Int){
        difficulty = level
    }
    func getDifficulty() -> Int {
        return difficulty
    }
    
    func setPointsPerWord (to newValue : Int) {
        pointsPerWord = newValue
        
    }
    
}
    

