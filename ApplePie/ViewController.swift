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
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
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
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,incorrectMovesRemaining:incorrectMovedAllowed,guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
            updateUI()
        }
    }
    
    func updateUI(){
        
        var letters = [String()]
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator:" ")
        correctWordLabel.text = wordWithSpacing
//        correctWordLabel.text = currentGame.formattedWord
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons {
            print(button)
            button.isEnabled = enable
        }
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        print(letterString)
        currentGame.playerGuessed(letter:letter)
        updatedGameState()
    }
    
    func updatedGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
}

