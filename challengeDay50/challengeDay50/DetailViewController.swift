//
//  DetailViewController.swift
//  challengeDay50
//
//  Created by Laurent on 2019-04-29.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var savedImage: SavedImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.backgroundColor = .gray

        if let savedImage = savedImage {
            let path = getDocumentsDirectory().appendingPathComponent(savedImage.image)
            
            if let image = UIImage(contentsOfFile: path.path) {
                imageView.image = image
            } else {
                print("error loading image")
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
