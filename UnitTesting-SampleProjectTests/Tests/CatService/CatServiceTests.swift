//
//  CatServiceTests.swift
//  UnitTesting-SampleProjectTests
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import XCTest
@testable import UnitTesting_SampleProject

final class CatServiceTests: XCTestCase {

    var sut: CatService!
    let sessionConfig = URLSessionConfiguration.ephemeral
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionConfig.protocolClasses = [MockUrlProtocol.self]
        urlSession = URLSession(configuration: sessionConfig)
        sut = CatService(networkService: NetworkService(urlSession: urlSession, baseURL: "https://www.mock.com"))
    }

    override func tearDown() {
        super.tearDown()
        urlSession = nil
        sut = nil
    }
    
    func test_WhenResponseIsSuccessfull() async throws {
        MockUrlProtocol.requestHandler = { request in
            let data = readLocalJSONFile(forName: "CatbreedJSON")
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, data!)
        }
        let exp = XCTestExpectation(description: "fetch request - successful")
        Task {
            let result = await sut.fetchCats(requestData: NetworkServiceRequest(httpMethod: .GET, endPoint: ""))
            if case let .success(model) = result {
                exp.fulfill()
                XCTAssertTrue(model.count > 0)
            } else if case let .failure(error) = result {
                exp.fulfill()
                XCTAssertThrowsError(error.localizedDescription)
            }
        }
        await fulfillment(of: [exp])
    }
    
    func test_WhenResponseIsNotSuccessfull() async throws {
        MockUrlProtocol.requestHandler = { request in
            let data = "{}".data(using: .utf8)
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, data!)
        }
        let exp = XCTestExpectation(description: "fetch request - successful")
        Task {
            let result = await sut.fetchCats(requestData: NetworkServiceRequest(httpMethod: .GET, endPoint: ""))
            if case let .success(model) = result {
                exp.fulfill()
                XCTAssertTrue(model.count > 0)
            } else if case let .failure(error) = result {
                exp.fulfill()
                XCTAssertNotNil(error)
            }
        }
        await fulfillment(of: [exp])
    }
}
