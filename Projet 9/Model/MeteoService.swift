//
//  MeteoService.swift
//  Projet 9
//
//  Created by Amg on 31/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class MeteoService {
    static var shared = MeteoService()
    private init() {}
    
    
    private let url = ""
    
    private var task: URLSessionTask?
    private var meteoSession = URLSession(configuration: .default)
    init(meteoSession: URLSession) {
        self.meteoSession = meteoSession
    }
    
    func getMeteo(text: String, callback: @escaping (Bool, Meteo) -> Void) {
    
    }
    
}
