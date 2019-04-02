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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

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
    
    @objc func shareTapped() {
        
        guard
            let image = imageView.image?.jpegData(compressionQuality: 0.8),
            let selectedImageName = selectedImage else {
            print("no image found")
            return
        }

        let vc = UIActivityViewController(activityItems: [image, selectedImageName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
