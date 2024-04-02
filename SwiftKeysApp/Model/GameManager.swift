//
//  GameManager.swift
//  SwiftKeysApp
//
//  Created by Kristian Thun on 2024-03-28.
//


import Foundation

class GameManager{
    private let words = [
        "boll", "hund", "katt", "bok", "hus", "näsa", "bär", "fisk", "mjölk", "axel",
        "öra", "peng", "klubb", "väska", "klocka", "hjul", "damm", "lejon", "skor", "vägg",
        "penna", "lampa", "glass", "sol", "fluga", "ring", "snö", "päls", "gräs", "stol",
        "fot", "våg", "häst", "hand", "båt", "bil", "hatt", "spik", "bana", "sax", "ögon",
        "träd", "måne", "horn", "mun", "sten", "näbb", "hjärta", "lock", "väv"
    ]

    private var wordToType: String?

    private var activePlayer: Player?
    private var pointsPerWord = 1
    private var wordsInGame: Int? = 2
    private var wordsDone: Int = 0
    


    func getRandomWord() -> String?{
        
        if wordsDone == wordsInGame {
            return nil
        }
        let word = words.randomElement()
        wordToType = word
        wordsDone += 1
        return wordToType
    }

    func correctSpelled(word: String) -> Bool{
        if word.lowercased() == wordToType?.lowercased() {
            activePlayer?.changeScore(with: pointsPerWord)
            return true
        }

        return false
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
    
    func addScore(scoreToAdd: Int){
        activePlayer?.changeScore(with: scoreToAdd)

        
    }
    func resetGame(){
        activePlayer?.score = 0
        wordsDone = 0
    }
    
    
    func getActivePlayer() -> Player?{
        return activePlayer
    }
    
 


}

