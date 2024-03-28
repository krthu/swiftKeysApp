//
//  GameManager.swift
//  SwiftKeysApp
//
//  Created by Kristian Thun on 2024-03-28.
//

import Foundation

class GameManger{
    private let words = [
        "boll", "hund", "katt", "bok", "hus", "näsa", "bär", "fisk", "mjölk", "axel",
        "öra", "peng", "klubb", "väska", "klocka", "hjul", "damm", "lejon", "skor", "vägg",
        "penna", "lampa", "glass", "sol", "fluga", "ring", "snö", "päls", "gräs", "stol",
        "fot", "våg", "häst", "hand", "båt", "bil", "hatt", "spik", "bana", "sax", "ögon",
        "träd", "måne", "horn", "mun", "sten", "näbb", "hjärta", "lock", "väv"
    ]
    
    private var wordToType: String?
    
//    private var activePlayer: Player?
    
    
    func getRandomWord() -> String?{
        let word = words.randomElement()
        wordToType = word
        return wordToType
    }
    
    func correctSpelled(word: String) -> Bool{
        if word.lowercased() == wordToType?.lowercased() {
            // Give player points
            return true
        }
        
        return false
    }
    
//    func getScore() -> Int{
//        return points
//    }
    
//    func setActivePlayer{
//        
//    }
    
    
    
}

