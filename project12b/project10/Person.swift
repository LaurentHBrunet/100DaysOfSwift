//
//  Person.swift
//  project10
//
//  Created by Laurent on 2019-04-23.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
