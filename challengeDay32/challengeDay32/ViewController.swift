//
//  ViewController.swift
//  challengeDay32
//
//  Created by Laurent on 2019-04-12.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
    }
    
    
    @objc func addItem() {
        var textField: UITextField?
        
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField { (UITextField) in
            textField = UITextField
        }
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            if let textField = textField {
                if let textFieldContent = textField.text {
                    self.shoppingList.insert(textFieldContent, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }))
        
        present(ac, animated: true)
    }
    
    @objc func clearList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "shoppingItem")
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
}

