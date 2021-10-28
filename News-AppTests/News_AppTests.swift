//
//  News_AppTests.swift
//  News-AppTests
//
//  Created by SCG on 10/25/21.
//

import XCTest
@testable import News_App

// Code from Ray Wenderlich: https://www.raywenderlich.com/21020457-ios-unit-testing-and-ui-testing-tutorial
class APITests: XCTestCase {
    
    let networkMonitor = NetworkMonitor.shared  // Checks network connection
    let networkManager = NetworkManager()     // Instance of View Model
    var sut: URLSession!    // SUT = System Under Test
    
    // Create the SUT in setUpWithError() and release it in tearDownWithError() to ensure every test starts with a clean slate
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

//MARK: - Tests News API in getArticles()
    func testValidAPI() throws {
        try XCTSkipUnless(
            networkMonitor.isReachable,
            "Network connectivity needed for this test.")
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(networkManager.apiKey)"
        let url = URL(string: urlString)!
        
        // 1. expectation(description:): Returns XCTestExpectation, stored in promise. description describes what you expect to happen
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2. promise.fulfill(): Call this in the success condition closure of the asynchronous method’s completion handler to flag that the expectation has been met
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3. wait(for:timeout:): Keeps the test running until all expectations are fulfilled or the timeout interval ends, whichever happens first
        wait(for: [promise], timeout: 5)
    }
    
    // Asynchronous test: faster fail
    func testAPICallCompletes() throws {
        try XCTSkipUnless(
            networkMonitor.isReachable,
            "Network connectivity needed for this test."
        )
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(networkManager.apiKey)"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
