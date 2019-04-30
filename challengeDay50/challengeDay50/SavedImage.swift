//
//  SavedImage.swift
//  challengeDay50
//
//  Created by Laurent on 2019-04-29.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import Foundation

class SavedImage: Codable {
    var image: String
    var caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}
