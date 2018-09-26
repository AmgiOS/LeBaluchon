//
//  FakeResponseData.swift
//  Projet9TestsCase
//
//  Created by Amg on 19/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class FakeResponseData {
    //MARK: RESPONSE
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    //MARK: ERROR
    class DeviceError: Error {}
    static let errorDevice = DeviceError()
    
    class TranslationError: Error{}
    static let errorTranslation = TranslationError()
    
    class MeteoError: Error {}
    static let errorMeteo = MeteoError()
    
    //MARK: CORRECT DATA
    //MARK: DEVICE
    static var deviceCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Device", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var deviceSymbolsCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "DeviceSymbols", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //MARK: TRANSLATION
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translationLanguagesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslationLanguages", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //MARK: WEATHER
    static var meteoCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Meteo", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //MARK: INCORRECT DATA
    static let deviceIncorrectData = "erreur".data(using: .utf8)!
    static let translationIncorrectData = "erreur".data(using: .utf8)!
    static let meteoIncorrectData = "erreur".data(using: .utf8)!
}
