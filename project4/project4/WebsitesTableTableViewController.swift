//
//  WebsitesTableTableViewController.swift
//  project4
//
//  Created by Laurent on 2019-04-04.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class WebsitesTableTableViewController: UITableViewController {
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "webView") as? ViewController {
            vc.initialWebsite = websites[indexPath.row]
            vc.websites = websites
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
