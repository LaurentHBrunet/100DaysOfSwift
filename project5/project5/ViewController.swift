//
//  ViewController.swift
//  project5
//
//  Created by Laurent on 2019-04-05.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        
        reloadGame()
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        saveCurrentWord()

        tableView.reloadData()
    }
    
    func reloadGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        
        let defaults = UserDefaults.standard
        
        if let savedCurrentWord = defaults.object(forKey: "currentWord") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                var savedTitleArray = try jsonDecoder.decode([String].self, from: savedCurrentWord)
                title = savedTitleArray[0]
            } catch {
                print("Failed to load current word.")
            }
        }
        
        if let savedGuessedWords = defaults.object(forKey: "guessedWords") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                usedWords = try jsonDecoder.decode([String].self, from: savedGuessedWords)
            } catch {
                print("Failed to load current word.")
            }
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        
        let errorTitle: String
        let errorMessage: String
        
        if answer.count > 2 {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        usedWords.insert(lowerAnswer, at: 0)
                        saveCurrentWord()
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    } else {
                        errorTitle = "Word not recognized"
                        errorMessage = "You can't make up words"
                    }
                } else {
                    errorTitle = "Word already used"
                    errorMessage = "Be more original!"
                }
            } else {
                guard let titleLowerCased = title?.lowercased() else { return }
                
                errorTitle = "Word not possible"
                errorMessage = "You can't spell that word from \(titleLowerCased)"
            }
        } else {
            errorTitle = "Empty word"
            errorMessage = "Word must be at least 3 characters long"
        }
        
        showErrorMessage(title: errorTitle, message: errorMessage)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        if word == tempWord {
            return false
        }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }
    
    func saveCurrentWord() {
        let jsonEncoder = JSONEncoder()
        let defaults = UserDefaults.standard
        
        if let savedGuessedWords = try? jsonEncoder.encode(usedWords) {
            defaults.set(savedGuessedWords, forKey: "guessedWords")
        } else {
            print("error encoding guessedWords")
        }
        
        if let savedTitle = try? jsonEncoder.encode([title!]) {
            defaults.set(savedTitle, forKey: "currentWord")
        } else {
            print("error encoding currentWord")
        }

    }
}

