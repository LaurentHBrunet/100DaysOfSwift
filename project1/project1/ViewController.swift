//
//  ViewController.swift
//  project1
//
//  Created by Laurent on 2019-03-11.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var shownImageCount = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendApp))

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            let defaults = UserDefaults.standard
            

            for item in items {
                if item.hasPrefix("nssl") {
                    self?.pictures.append(item)
                    self?.shownImageCount.append(0)
                }
            }
            
            if let savedData = defaults.object(forKey: "shownImageCount") as? Data {
                let jsonDecoder = JSONDecoder()
                
                do {
                    self?.shownImageCount = try jsonDecoder.decode([Int].self, from: savedData)
                    self?.tableView.reloadData()
                } catch {
                    print("Error loading savedImageCount")
                }
            }
            
            self?.pictures.sort()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "\(shownImageCount[indexPath.row])"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            shownImageCount[indexPath.row] += 1
            tableView.reloadData()
            save()
            
            detailVC.selectedImage = pictures[indexPath.row]
            detailVC.imageIndex = indexPath.row
            detailVC.imageArraySize = pictures.count

            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @objc func recommendApp() {
        let vc = UIActivityViewController(activityItems: ["Check out this app"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(shownImageCount) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "shownImageCount")
        }
    }
}

