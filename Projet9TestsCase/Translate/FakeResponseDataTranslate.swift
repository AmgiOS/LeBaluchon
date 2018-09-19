//
//  FakeResponseData.swift
//  Projet9TestsCase
//
//  Created by Amg on 19/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class FakeResponseDataTranslate {
    //MARK: RESPONSE
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    //MARK: ERROR
    class TranslationError: Error{}
    static let errorTranslation = TranslationError()
    
    //MARK: CORRECT DATA
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataTranslate.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translationLanguagesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataTranslate.self)
        let url = bundle.url(forResource: "TranslationLanguages", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //MARK: INCORRECT DATA
    static let translationIncorrectData = "erreur".data(using: .utf8)!
}
