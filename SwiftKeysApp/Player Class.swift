//
//  Player Class.swift
//  SwiftKeysApp
//
//  Created by Jennet on 2024-03-28.
//

import Foundation

class Player {
    var name : String
    var score : Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    func increaceScore(scoreToAdd : Int) {
        score += scoreToAdd
    }
    func toString() -> String {
        
        return "\(name) \(score)"
    }
}
