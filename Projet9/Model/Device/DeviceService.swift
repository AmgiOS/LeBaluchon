//
//  DeviceService.swift
//  Projet 9
//
//  Created by Amg on 28/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class DeviceService {
    //MARK: VARIABLES
    private static let urlBase = URL(string: "http://data.fixer.io/api/latest?access_key=f634e71e9b2bbd5bf2eed8f0d69e1d76")!
    private let urlSymbols = URL(string:"http://data.fixer.io/api/symbols?access_key=f634e71e9b2bbd5bf2eed8f0d69e1d76")!
    
    private var task: URLSessionTask?
    private var deviceSession = URLSession(configuration: .default)
    private var symbolsSession = URLSession(configuration: .default)
    
    init(deviceSession: URLSession = URLSession(configuration: .default), symbolsSession: URLSession = URLSession(configuration: .default)) {
        self.deviceSession = deviceSession
        self.symbolsSession = symbolsSession
    }
    
    //MARK: FUNCTIONS
    private func requestDevice() -> URLRequest {
        var request = URLRequest(url: DeviceService.urlBase)
        request.httpMethod = "GET"
        return request
    }
    
    func getDevice(Amount: String, callback: @escaping (Bool, Device?) -> Void) {
        let request = requestDevice()
        task?.cancel()
        task = deviceSession.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Device.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let device = Device(base: responseJSON.base, rates: responseJSON.rates)
                callback(true, device)
            }
        })
        task?.resume()
    }
    
    func getSymbols(completionHandler: @escaping ([String]?) -> Void) {
        var request = URLRequest(url: urlSymbols)
        request.httpMethod = "GET"
        
        task?.cancel()
        task = symbolsSession.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Symbols.self, from: data) else {
                    completionHandler(nil)
                    return
                }
                var arraySymbols = [String]()
                responseJSON.symbols.forEach({ (key, value) in
                    arraySymbols.append(key)
                })
                completionHandler(arraySymbols)
            }
        })
        task?.resume()
    }
}
