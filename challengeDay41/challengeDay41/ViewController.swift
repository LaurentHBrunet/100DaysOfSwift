//
//  ViewController.swift
//  challengeDay41
//
//  Created by Laurent on 2019-04-23.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var failedLetters = [String]()
    var wordsList = ["RHYTHM", "PLACEBO", "MARKER"]
    var currentWord: String = ""
    var incompleteWord: String = ""
    
    var incompleteWordLabel = UILabel()
    var guessedLettersTittle = UILabel()
    var guessedLetters = UILabel()
    
    var buttonsView = UIView()
    var guessButtons = [UIButton]()
    
    var alphaButtonsList = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var wrongGuesses = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(incompleteWordLabel)
        incompleteWordLabel.translatesAutoresizingMaskIntoConstraints = false
        incompleteWordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        incompleteWordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        incompleteWordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        incompleteWordLabel.textAlignment = .center
        
        view.addSubview(guessedLettersTittle)
        guessedLettersTittle.translatesAutoresizingMaskIntoConstraints = false
        guessedLettersTittle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        guessedLettersTittle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        guessedLettersTittle.topAnchor.constraint(equalTo: incompleteWordLabel.bottomAnchor, constant: 16).isActive = true
        guessedLettersTittle.textAlignment = .center
        guessedLettersTittle.text = "Your guesses"
        
        view.addSubview(guessedLetters)
        guessedLetters.translatesAutoresizingMaskIntoConstraints = false
        guessedLetters.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        guessedLetters.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        guessedLetters.topAnchor.constraint(equalTo: guessedLettersTittle.bottomAnchor, constant: 16).isActive = true
        guessedLetters.textAlignment = .center
        guessedLetters.text = ""
        
        view.addSubview(buttonsView)
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        buttonsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        buttonsView.topAnchor.constraint(equalTo: guessedLetters.bottomAnchor).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        initializeAlphaButtons()
        
        startGame()
    }
    
    private func startGame() {
        
        currentWord = wordsList.randomElement()!
        incompleteWord = ""
        wrongGuesses = 0
        guessedLetters.text = ""
        
        
        for _ in 0..<currentWord.count {
            incompleteWord.append("?")
        }
        
        incompleteWordLabel.text = incompleteWord
    }
    
    private func initializeAlphaButtons() {
//        let buttonsViewWidth = buttonsView.bounds.width
//        let buttonsViewHeight = buttonsView.bounds.height
//
//        let buttonWidth = Int(round(buttonsViewWidth * 0.15))
//        let buttonHeight = Int(round(buttonsViewHeight * 0.10))
//
        let buttonWidth = 50
        let buttonHeight = 50
        
        for row in 0..<6 {
            for column in 0..<5 {
                if row == 5 && column > 0 {
                    continue
                }
                
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                letterButton.layer.borderColor = UIColor.darkGray.cgColor
                letterButton.layer.borderWidth = 1
                
                let frame = CGRect(x: column * buttonWidth, y: row * buttonHeight, width: buttonWidth, height: buttonHeight)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                guessButtons.append(letterButton)
            }
        }
        
        for (index, button) in guessButtons.enumerated() {
            button.setTitle(alphaButtonsList[index], for: .normal)
        }
        
        
    }
    
    @objc private func letterTapped(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text {
            
            if currentWord.contains(buttonText) {
                for (index,letter) in currentWord.enumerated() {
                    if String(letter) == buttonText {
                        let oldWordLabelText = incompleteWordLabel.text
                        incompleteWordLabel.text? = (oldWordLabelText?.prefix(index))! + buttonText + (oldWordLabelText?.dropFirst(index + 1))!
                    }
                }
                
                
            } else {
                guessedLetters.text?.append(buttonText)
                wrongGuesses += 1
                
                if (wrongGuesses == 7) {
                    startGame()
                }
            }
        }
    }
}

