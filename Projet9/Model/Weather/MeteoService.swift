//
//  MeteoService.swift
//  Projet 9
//
//  Created by Amg on 31/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class MeteoService {
    //MARK: VARIABLES
    private let url = "https://query.yahooapis.com/v1/public/yql?q="
    private let urlFormat = "&format=json"
    private let baseRequest = "select item.condition, location.city from weather.forecast where woeid in (select woeid from geo.places(1) where "
    private let degreEndPoint = "') and u='c'"
    
    private var task: URLSessionTask?
    private var meteoSession = URLSession(configuration: .default)
    init(meteoSession: URLSession = URLSession(configuration: .default)) {
        self.meteoSession = meteoSession
    }
    
    //MARK: FUNCTIONS
    private func urlWeatherApi(country: [String]) -> String {
        var parameters = String()
        for (index, value) in country.enumerated() {
            if index == 0 {
                parameters += "text='\(value)"
            } else {
                parameters += "'or text='\(value)"
            }
        }
        let request = baseRequest + parameters + degreEndPoint
        guard let urlRequestEncoded = request.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        let requestFinal = url + urlRequestEncoded + urlFormat
        print(requestFinal)
        return requestFinal
    }
    
    func getMeteo(country: [String], callback: @escaping (Bool, Meteo?) -> Void) {
        guard let url = URL(string: urlWeatherApi(country: country)) else {return}
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
