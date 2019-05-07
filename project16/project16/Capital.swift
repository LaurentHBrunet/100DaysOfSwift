//
//  Capital.swift
//  project16
//
//  Created by Laurent on 2019-05-06.
//  Copyright © 2019 Laurent Henault-Brunet. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
