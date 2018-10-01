//
//  Device.swift
//  Projet 9
//
//  Created by Amg on 28/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

struct Meteo: Decodable {
    let query: Query
}

struct Query: Decodable {
    let results: Results
}

struct Results: Decodable {
    let channel: [Channel]
}

struct Channel: Decodable {
    let location: Location
    let item: Item
}

struct Location: Decodable {
    let city: String
}

struct Item: Decodable {
    let condition: Condition
}

struct Condition: Decodable {
    let date: String
    let temp: String
    let text: String
}
