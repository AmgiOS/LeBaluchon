//
//  FakeResponseData.swift
//  Projet9TestsCase
//
//  Created by Amg on 19/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class FakeResponseDataDevice {
    //MARK: RESPONSE
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    //MARK: ERROR
    class DeviceError: Error {}
    static let errorDevice = DeviceError()
    
    //MARK: CORRECT DATA
    static var deviceCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataDevice.self)
        let url = bundle.url(forResource: "Device", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var deviceSymbolsCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataDevice.self)
        let url = bundle.url(forResource: "DeviceSymbols", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //MARK: INCORRECT DATA
    static let deviceIncorrectData = "erreur".data(using: .utf8)!
}
