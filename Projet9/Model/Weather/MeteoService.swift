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
    
    private let url = "https://query.yahooapis.com/v1/public/yql?"
    
    private var task: URLSessionTask?
    private var meteoSession = URLSession(configuration: .default)
    init(meteoSession: URLSession) {
        self.meteoSession = meteoSession
    }
    
    func getMeteo(country: String, callback: @escaping (Bool, Meteo?) -> Void) {
        let q = "q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22" + country
        let format = "%2C%20%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        guard let url = URL(string: url + q + format) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        task?.cancel()
        task = meteoSession.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Meteo.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let meteo = Meteo(query: responseJSON.query)
                callback(true, meteo)
            }
        })
        task?.resume()
    }
}
