//
//  DeviceTest.swift
//  Projet9TestsCase
//
//  Created by Amg on 19/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import XCTest
@testable import Projet9

class DeviceTest: XCTestCase {

    //MARK: DEVICE TEST
    func testGetDeviceShouldPostFailedCallbackIfError() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: nil, response: nil, error: FakeResponseDataDevice.errorDevice),
            symbolsSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getDevice(Amount: "") { (success, device) in
            XCTAssertFalse(success)
            XCTAssertNil(nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviceShouldPostFailedCallbackIfNoData() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: nil, response: nil, error: nil),
            symbolsSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getDevice(Amount: "") { (success, device) in
            XCTAssertFalse(success)
            XCTAssertNil(nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviceShouldPostFailedCallbackIfIncorrectResponse() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: FakeResponseDataDevice.deviceCorrectData, response: FakeResponseDataDevice.responseKO, error: nil),
            symbolsSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getDevice(Amount: "") { (success, device) in
            XCTAssertFalse(success)
            XCTAssertNil(nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviceShouldPostFailedCallbackIfIncorrectData() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: FakeResponseDataDevice.deviceIncorrectData, response: FakeResponseDataDevice.responseOK, error: nil),
            symbolsSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getDevice(Amount: "") { (success, device) in
            XCTAssertFalse(success)
            XCTAssertNil(nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviceShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: FakeResponseDataDevice.deviceCorrectData, response: FakeResponseDataDevice.responseOK, error: nil),
            symbolsSession: URLSessionFake(data: FakeResponseDataDevice.deviceCorrectData, response: FakeResponseDataDevice.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getDevice(Amount: "") { (success, device) in
            let base = "EUR"
            let rates = ["AED": 4.293634,
                         "AFN": 86.91419,
                         "ALL": 126.76834,
                         "AMD": 567.224903,
                         "ANG": 2.15477,
                         "AOA": 335.014512,
                         "ARS": 46.140303,
                         "AUD": 1.625018,
                         "AWG": 2.106958,
                         "AZN": 1.990063,
                         "BAM": 1.863355,
                         "BBD": 2.337584,
                         "BDT": 97.984905,
                         "BGN": 1.955464,
                         "BHD": 0.440848,
                         "BIF": 2087.671033,
                         "BMD": 1.168909,
                         "BND": 1.766157,
                         "BOB": 8.070088,
                         "BRL": 4.917132,
                         "BSD": 1.167798,
                         "BTC": 0.000181,
                         "BTN": 83.688226,
                         "BWP": 12.637659,
                         "BYN": 2.51011,
                         "BYR": 22910.61156,
                         "BZD": 2.347407,
                         "CAD": 1.519523,
                         "CDF": 1900.645264,
                         "CHF": 1.128505,
                         "CLF": 0.026416,
                         "CLP": 797.295854,
                         "CNY": 8.001167,
                         "COP": 3534.25406,
                         "CRC": 677.663518,
                         "CUC": 1.168909,
                         "CUP": 30.976082,
                         "CVE": 111.630202,
                         "CZK": 25.514703,
                         "DJF": 207.73872,
                         "DKK": 7.458866,
                         "DOP": 58.234698,
                         "DZD": 137.694367,
                         "EGP": 20.953273,
                         "ERN": 17.534083,
                         "ETB": 32.554626,
                         "EUR": 1,
                         "FJD": 2.50351,
                         "FKP": 0.900071,
                         "GBP": 0.891649,
                         "GEL": 3.056756,
                         "GGP": 0.891745,
                         "GHS": 5.745165,
                         "GIP": 0.900072,
                         "GMD": 56.633584,
                         "GNF": 10637.070026,
                         "GTQ": 8.940224,
                         "GYD": 244.144115,
                         "HKD": 9.174122,
                         "HNL": 28.135531,
                         "HRK": 7.434616,
                         "HTG": 80.913,
                         "HUF": 324.091235,
                         "IDR": 17234.390655,
                         "ILS": 4.174465,
                         "IMP": 0.891745,
                         "INR": 83.688008,
                         "IQD": 1392.754779,
                         "IRR": 49216.902794,
                         "ISK": 130.403145,
                         "JEP": 0.891745,
                         "JMD": 159.614465,
                         "JOD": 0.830863,
                         "JPY": 130.841774,
                         "KES": 118.310965,
                         "KGS": 81.4152,
                         "KHR": 4792.525923,
                         "KMF": 492.636276,
                         "KPW": 1052.018207,
                         "KRW": 1309.212885,
                         "KWD": 0.353958,
                         "KYD": 0.973222,
                         "KZT": 437.358672,
                         "LAK": 9956.764676,
                         "LBP": 1766.220915,
                         "LKR": 190.356954,
                         "LRD": 180.597254,
                         "LSL": 17.451893,
                         "LTL": 3.563657,
                         "LVL": 0.725367,
                         "LYD": 1.618894,
                         "MAD": 10.976635,
                         "MDL": 19.623581,
                         "MGA": 3980.134041,
                         "MKD": 61.664641,
                         "MMK": 1818.996999,
                         "MNT": 2904.00703,
                         "MOP": 9.441802,
                         "MRO": 417.888469,
                         "MUR": 40.338029,
                         "MVR": 18.012893,
                         "MWK": 850.150362,
                         "MXN": 22.015692,
                         "MYR": 4.851559,
                         "MZN": 70.5202,
                         "NAD": 20.771638,
                         "NGN": 424.314255,
                         "NIO": 37.533427,
                         "NOK": 9.606794,
                         "NPR": 134.582295,
                         "NZD": 1.778847,
                         "OMR": 0.450047,
                         "PAB": 1.167681,
                         "PEN": 3.874897,
                         "PGK": 3.877296,
                         "PHP": 63.092436,
                         "PKR": 145.09077,
                         "PLN": 4.302578,
                         "PYG": 6815.206037,
                         "QAR": 4.256026,
                         "RON": 4.641617,
                         "RSD": 118.412829,
                         "RUB": 79.842285,
                         "RWF": 1011.106071,
                         "SAR": 4.384462,
                         "SBD": 9.342623,
                         "SCR": 15.902414,
                         "SDG": 21.01932,
                         "SEK": 10.46793,
                         "SGD": 1.601287,
                         "SHP": 1.544012,
                         "SLL": 9820.002975,
                         "SOS": 674.460417,
                         "SRD": 8.717714,
                         "STD": 24858.380199,
                         "SVC": 10.219656,
                         "SYP": 601.988069,
                         "SZL": 17.446008,
                         "THB": 38.118398,
                         "TJS": 11.003231,
                         "TMT": 4.097025,
                         "TND": 3.236942,
                         "TOP": 2.685681,
                         "TRY": 7.108136,
                         "TTD": 7.871724,
                         "TWD": 35.960283,
                         "TZS": 2668.385278,
                         "UAH": 32.799586,
                         "UGX": 4447.928731,
                         "USD": 1.168909,
                         "UYU": 38.398165,
                         "UZS": 9222.690186,
                         "VEF": 290497.144905,
                         "VND": 27208.689045,
                         "VUV": 133.685755,
                         "WST": 3.092509,
                         "XAF": 659.157249,
                         "XAG": 0.082445,
                         "XAU": 0.000973,
                         "XCD": 3.159035,
                         "XDR": 0.833762,
                         "XOF": 677.966899,
                         "XPF": 119.66702,
                         "YER": 292.588274,
                         "ZAR": 17.276587,
                         "ZMK": 10521.572927,
                         "ZMW": 12.114539,
                         "ZWL": 376.803594]
            XCTAssertTrue(success)
            XCTAssertNotNil(device)
            XCTAssertEqual(base, device?.base)
            XCTAssertEqual(rates, device?.rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: DEVICE SYMBOLS TEST
    func testGetDeviceShouldPostFailedCallbackIfNilAndError() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: nil, response: nil, error: nil),
            symbolsSession: URLSessionFake(data: nil, response: nil, error: FakeResponseDataDevice.errorDevice))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getSymbols { (array) in
            XCTAssertNil(array)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetDeviceShouldPostFailedCallbackIfNoDataSymbols() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: nil, response: nil, error: nil),
            symbolsSession: URLSessionFake(data: FakeResponseDataDevice.deviceSymbolsCorrectData, response: FakeResponseDataDevice.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getSymbols { (array) in
            XCTAssertNil(array)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviceShouldPostFailedCallbackIfIncorrectResponseSymbols() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: nil, response: nil, error: nil),
            symbolsSession: URLSessionFake(data: FakeResponseDataDevice.deviceIncorrectData, response: FakeResponseDataDevice.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getSymbols { (array) in
            XCTAssertNil(array)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviceShouldPostCorrectCallbackIfCorrectArraySymbolsAndError() {
        let deviceService = DeviceService(
            deviceSession: URLSessionFake(data: nil, response: nil, error: nil),
            symbolsSession: URLSessionFake(data: FakeResponseDataDevice.deviceSymbolsCorrectData, response: FakeResponseDataDevice.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        deviceService.getSymbols { (symbols) in
            XCTAssertNotNil(symbols)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    

}
