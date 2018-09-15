//
//  Device Struct.swift
//  Projet 9
//
//  Created by Amg on 10/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

struct Device: Decodable {
    var base: String
    var rates: [String: Double]
}

struct Symbols: Decodable {
    var symbols: [String: String]
}
