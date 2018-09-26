//
//  TranslateTest.swift
//  Projet9TestsCase
//
//  Created by Amg on 19/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import XCTest
@testable import Projet9

class TranslateTest: XCTestCase {

    //MARK: TRANSLATE TEST
    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTranslation),
            languagesSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getTranslate(text: "", target: "") { (success, translate) in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
            languagesSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getTranslate(text: "", target: "") { (success, translate) in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponseTranslate() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil),
            languagesSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getTranslate(text: "", target: "") { (success, translate) in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectDataAndCorrectResponse() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translationIncorrectData, response: FakeResponseData.responseOK, error: nil),
            languagesSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getTranslate(text: "", target: "") { (success, translate) in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostSuccessCallbackIfCorrectDataAndResponse() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil),
            languagesSession: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getTranslate(text: "", target: "") { (success, translate) in
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    //MARK: TRANSLATION LANGUAGES TEST
    func testGetTranslationShouldPostFailedCallbackIfErrorLanguages() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
            languagesSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTranslation))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getLanguages { (languages) in
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfCorrectDataAndIncorrectResponse() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
            languagesSession: URLSessionFake(data: FakeResponseData.translationLanguagesCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getLanguages { (languages) in
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectDataAndCorrectResponseLanguages() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
            languagesSession: URLSessionFake(data: FakeResponseData.translationIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getLanguages { (languages) in
            XCTAssertNil(languages)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostSuccessCallbackIfCorrectDataAndCorrectResponseLanguages() {
        let translationService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
            languagesSession: URLSessionFake(data: FakeResponseData.translationLanguagesCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translationService.getLanguages { (languages) in
            XCTAssertNotNil(languages)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

}
