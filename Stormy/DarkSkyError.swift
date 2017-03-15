//
//  DarkSkyError.swift
//  Stormy
//
//  Created by James Rochabrun on 3/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

//6 error handling
enum DarkSkyError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case invalidURL
    case jsonParsingFailure
}
