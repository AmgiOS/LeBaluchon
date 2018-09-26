//
//  Device.swift
//  Projet 9
//
//  Created by Amg on 28/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

struct Meteo: Decodable {
    var query: Results
}

struct Results: Decodable {
    var results: Channel
}

struct Channel: Decodable {
    var channel: Item
}

struct Item: Decodable {
    var description: String
    var lastBuildDate: String
    var item: DataItem
}

struct DataItem: Decodable {
    var title: String
    var condition: Temperature
}

struct Temperature: Decodable {
    var temp: String
    var text: String
}

class MeteoComponents {
    var countryMeteo: String
    var descriptionMeteo: String
    var dateMeteo: String
    var tempMeteo: String
    
    init(countryMeteo: String, descriptionMeteo: String, dateMeteo: String, tempMeteo: String) {
        self.countryMeteo = countryMeteo
        self.descriptionMeteo = descriptionMeteo
        self.dateMeteo = dateMeteo
        self.tempMeteo = tempMeteo
    }
}
