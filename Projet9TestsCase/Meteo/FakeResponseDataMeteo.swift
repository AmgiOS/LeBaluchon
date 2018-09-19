//
//  FakeResponseData.swift
//  Projet9TestsCase
//
//  Created by Amg on 19/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class FakeResponseDataMeteo {
    //MARK: RESPONSE
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    //MARK: ERROR
    
    class MeteoError: Error {}
    static let errorMeteo = MeteoError()
    
    //MARK: CORRECT DATA
    static var meteoCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataMeteo.self)
        let url = bundle.url(forResource: "Meteo", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //MARK: INCORRECT DATA
    static let meteoIncorrectData = "erreur".data(using: .utf8)!
    
}
