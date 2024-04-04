//
//  HighScoreList.swift
//  SwiftKeysApp
//
//  Created by Kristian Thun on 2024-04-02.
//

import Foundation

class HighScoreManager {
    private var list : [Player] = []
    private var defaultsKey = "listKey"
    
    
    
    func addPlayer(playerToAdd: Player){
        list.append(playerToAdd)
    }
    
    func getList() -> [Player] {
        let sortedList = list.sorted { $0.score > $1.score }
        return sortedList
    }
    
    func saveListToUserDefaults(){
        do {
            let data = try JSONEncoder().encode(list)
            UserDefaults.standard.set(data, forKey: defaultsKey)
            
        }
        catch{
            print("Error saveing to defaults")
        }
    }
    
    func loadListFromUserDefaults(){
        if let data = UserDefaults.standard.data(forKey: defaultsKey){
            do{
                list = try JSONDecoder().decode([Player].self, from: data)
                
            } catch {
                print("Error readingData")
            }
        }
        
    }
    
    

    
}
