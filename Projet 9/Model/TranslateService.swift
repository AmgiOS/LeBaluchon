//
//  TranslateService.swift
//  Projet 9
//
//  Created by Amg on 31/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class TranslateService {
    static var shared = TranslateService()
    private init() {}
    
    private let urlbase = "https://translation.googleapis.com/language/translate/v2?"
    private static let languagesUrl = URL(string: "https://translation.googleapis.com/language/translate/v2/languages?key=AIzaSyC1ZxcC7a_dOzo92PFkbA2JMgHz_GTqM7U")!
    
    private var task: URLSessionTask?
    
    private var translateSession = URLSession(configuration: .default)
    private var languagesSession = URLSession(configuration: .default)
    
    init(translateSession: URLSession, languagesSession: URLSession) {
        self.translateSession = translateSession
        self.languagesSession = languagesSession
    }
    
    func getTranslate(text: String, target: String, callback: @escaping (Bool, DataTranslate?) -> Void) {
        let target = "&target=" + target
        let api = "&key=AIzaSyC1ZxcC7a_dOzo92PFkbA2JMgHz_GTqM7U"
        let nmt = "&model=base"
        let urlTotal = urlbase + target + api + nmt
        guard let url = URL(string: urlTotal) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "q=" + text
        request.httpBody = body.data(using: .utf8)
        
        task?.cancel()
        task = translateSession.dataTask(with: request, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print(1)
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(DataTranslate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let translate = DataTranslate(data: responseJSON.data)
                callback(true, translate)
            }
        })
        task?.resume()
    }
    
    func getLanguages(completionHandler: @escaping ([String]?) -> Void) {
        var request = URLRequest(url: TranslateService.languagesUrl)
        request.httpMethod = "GET"
        
        task?.cancel()
        task = languagesSession.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(LanguagesData.self, from: data) else {
                    completionHandler(nil)
                    return
                }
                var arrayLanguages = [String]()
                for element in responseJSON.data.languages {
                    arrayLanguages.append(element.language)
                }
                completionHandler(arrayLanguages)
                
            }
        })
        task?.resume()
    }
}
