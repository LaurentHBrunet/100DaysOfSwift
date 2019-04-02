//
//  DetailViewController.swift
//  challengeDay23
//
//  Created by Laurent on 2019-04-01.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var countryImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
        
        if let countryImageToShow = countryImage {
            imageView.image = UIImage(named: countryImageToShow)
        }
    }
    
    @objc func shareFlag() {
        if let flagImageToShare = imageView.image {
            let activityVC = UIActivityViewController(activityItems: [flagImageToShare], applicationActivities: [])
            activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            
            present(activityVC, animated: true)
        }
    }
}
