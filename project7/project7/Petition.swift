//
//  Petition.swift
//  project7
//
//  Created by Laurent on 2019-04-12.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
