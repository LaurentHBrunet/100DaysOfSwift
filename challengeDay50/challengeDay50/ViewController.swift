//
//  ViewController.swift
//  challengeDay50
//
//  Created by Laurent on 2019-04-29.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var savedImages = [SavedImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePicture))
        
        let defaults = UserDefaults.standard
        
        if let savedData = defaults.object(forKey: "savedImages") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                savedImages = try jsonDecoder.decode([SavedImage].self, from: savedData)
            } catch {
                print(error)
            }
        }
    }
    
    
    @objc private func takePicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            DispatchQueue.main.async { [weak self] in
                let ac = UIAlertController(title: "Save caption", message: "Write a caption for your picture.", preferredStyle: .alert)
                ac.addTextField()
                
                ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
                    guard let image = info[.editedImage] as? UIImage else { return }
                    
                    let imageName = UUID().uuidString
                    let imagePath = self?.getDocumentsDirectory().appendingPathComponent(imageName)
                    
                    if let jpegData = image.jpegData(compressionQuality: 0.8), let imagePath = imagePath {
                        do {
                            try jpegData.write(to: imagePath)
                            print(imagePath)
                        } catch {
                            print(error)
                        }
                    }
                    
                    if let caption = ac.textFields?[0].text {
                        let savedImage = SavedImage(image: imageName, caption: caption)
                        self?.savedImages.append(savedImage)
                        self?.save()
                        self?.tableView.reloadData()
                    }
                }))
                
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

                self?.present(ac, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        savedImages.remove(at: indexPath.row)
        save()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CaptionCell") else { fatalError("Unable to dequeue cell") }
        cell.textLabel?.text = savedImages[indexPath.row].caption
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.savedImage = savedImages[indexPath.row]
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(savedImages) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "savedImages")
        } else {
            print("Failed to save images")
        }
    }
}

