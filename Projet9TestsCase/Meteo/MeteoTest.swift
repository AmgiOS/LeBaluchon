//
//  MeteoTest.swift
//  Projet9TestsCase
//
//  Created by Amg on 19/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import XCTest
@testable import Projet9

class MeteoTest: XCTestCase {

    //MARK: METEO TEST
    func testGetMeteoShouldPostFailedCallbackIfError() {
        let meteoService = MeteoService(
            meteoSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorMeteo))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        meteoService.getMeteo(country: "") { (success, meteo) in
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMeteoShouldPostFailedCallbackIfNoData() {
        let meteoService = MeteoService(
            meteoSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        meteoService.getMeteo(country: "") { (success, meteo) in
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMeteoShouldPostFailedCallbackIfIncorrectResponse() {
        let meteoService = MeteoService(
            meteoSession: URLSessionFake(data: FakeResponseData.meteoCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        meteoService.getMeteo(country: "") { (success, meteo) in
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMeteoShouldPostFailedCallbackIfIncorrectData() {
        let meteoService = MeteoService(
            meteoSession: URLSessionFake(data: FakeResponseData.meteoIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        meteoService.getMeteo(country: "") { (success, meteo) in
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMeteoShouldPostSuccessCallbackIfCorrectDataAndResponse() {
        let meteoService = MeteoService(
            meteoSession: URLSessionFake(data: FakeResponseData.meteoCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        meteoService.getMeteo(country: "") { (success, meteo) in
            XCTAssertTrue(success)
            XCTAssertNotNil(meteoService)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
