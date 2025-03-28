//
//  ViewController.swift
//  ApplePie
//
//  Created by George McKinney on 3/21/25.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["lancer","pcc","pasadena","swift","artist"]
    let incorrectMovedAllowed = 7
    
    var totalWins = 0
    var totalLosses = 0
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }

    var currentGame: Game!
    
    func newRound(){
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord,incorrectMovesRemaining:incorrectMovedAllowed,guessedLetters: [])
        updateUI()
    }
    
    func updateUI(){
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        print(letterString)
        currentGame.playerGuessed(letter:letter)
        updateUI()
    }
    
}

