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
    var highScore = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let savedHighScore = defaults.object(forKey: "highScore") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                highScore = try jsonDecoder.decode(Int.self, from: savedHighScore)
            } catch {
                print("error loading high score")
            }
        }
        
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
        
        button1.transform = .identity
        button2.transform = .identity
        button3.transform = .identity

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
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        })
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, that is the flag of \(countries[sender.tag])"
            score -= 1
        }
        

        if questionCount == 10 {
            
            if score > highScore {
                saveHighScore()
                
                let newHighScoreAC = UIAlertController(title: "New high score!", message: "Your new high score is  \(score)", preferredStyle: .alert)
                newHighScoreAC.addAction(UIAlertAction(title: "Play again", style: .default, handler: restartGame))
                present(newHighScoreAC, animated: true)
            } else {
                let finalAC = UIAlertController(title: "Final score", message: "Your final score is \(score)", preferredStyle: .alert)
                finalAC.addAction(UIAlertAction(title: "Start again", style: .default, handler: restartGame))
                present(finalAC, animated: true)
            }
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
    
    func saveHighScore() {
        let jsonEncoder = JSONEncoder()
        
        if let savedHighScore = try? jsonEncoder.encode(highScore) {
            let defaults = UserDefaults.standard
            defaults.set(savedHighScore, forKey: "highScore")
        }
    }
}

