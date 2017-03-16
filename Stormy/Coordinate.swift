//
//  Coordinate.swift
//  Stormy
//
//  Created by James Rochabrun on 3/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

//COORDINATE HELPER
struct Coordinate {
    var latitude: Double 
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
