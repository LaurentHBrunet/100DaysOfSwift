//
//  ViewController.swift
//  project2
//
//  Created by Laurent on 2019-03-31.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) Score : \(score)"
        
        questionCount += 1
    }
    
    func restartGame(action: UIAlertAction) {
        score = 0
        questionCount = 0
        
        askQuestion(action: nil)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, that is the flag of \(countries[sender.tag])"
            score -= 1
        }
        

        if questionCount == 10 {
            let finalAC = UIAlertController(title: "Final score", message: "Your final score is \(score)", preferredStyle: .alert)
            finalAC.addAction(UIAlertAction(title: "Start again", style: .default, handler: restartGame))
            present(finalAC, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    @objc func showScore() {
        let scoreAC = UIAlertController(title: "Current score", message: "Your score is \(score)", preferredStyle: .alert)
        scoreAC.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(scoreAC, animated: true)
    }
}

