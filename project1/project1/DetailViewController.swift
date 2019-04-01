//
//  DetailViewController.swift
//  project1
//
//  Created by Laurent on 2019-03-11.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var imageIndex: Int?
    var imageArraySize: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let indexToShow = imageIndex, let arraySizeToShow = imageArraySize {
            title = "Picture \(indexToShow + 1) of \(arraySizeToShow)"
        }
        
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
