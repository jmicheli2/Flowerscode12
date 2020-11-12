//
//  Capital.swift
//  Flowers
//
//  Created by Jacques Micheli on 08/11/2020.
//  Copyright © 2020 byrdland. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D // Only mandatory property for MKAnnotation
    var info: String
    var more: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String, more: String) {
        print("init Capital")
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.more = more
    }
}

