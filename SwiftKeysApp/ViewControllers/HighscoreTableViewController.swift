//
//  HighscoreTableViewController.swift
//  SwiftKeysApp
//
//  Created by Mattias Axelsson on 2024-03-28.
//

import UIKit

class HighscoreTableViewController: UITableViewController {
    
    var highscoreManager = HighScoreManager()
    
    var highScoreList : [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        highscoreManager.loadListFromUserDefaults()
        highScoreList = highscoreManager.getList()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return highScoreList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "highscoreCell", for: indexPath) as? HighscoreTableViewCell else {
            fatalError("Unable to dequeue TableViewCell") }
        
        cell.positionLabel.text = "\(indexPath.row + 1)"
        cell.playerName.text = highScoreList[indexPath.row].name
        cell.playerScore.text = "\(highScoreList[indexPath.row].score)p"
            
        return cell
       
    }


}
