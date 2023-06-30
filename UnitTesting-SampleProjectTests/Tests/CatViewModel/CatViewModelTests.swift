//
//  CatViewModelTests.swift
//  UnitTesting-SampleProjectTests
//
//  Created by Daniyal Yousuf on 2023-06-29.
//

import XCTest
@testable import UnitTesting_SampleProject

final class CatViewModelTests: XCTestCase {
    
    var sut: CatViewModel!
    var mockCatService: MockCatService!
    
    override func setUp() {
        super.setUp()
        mockCatService = MockCatService()
        sut = CatViewModel(catService: mockCatService)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockCatService = nil
    }
    
    func test_fetchCats_Successful() async {
        mockCatService.isResponseSuccessfull = true
        Task {
            let result = await sut.fetchCats(request: NetworkServiceRequest(httpMethod: .GET, endPoint: ""))
            if case .success = result {
                XCTAssertTrue(mockCatService.isResponseSuccessfull)
            }
        }
    }
    
    func test_fetchCats_Failed() async {
        mockCatService.isResponseSuccessfull = false
        Task {
            let result = await sut.fetchCats(request: NetworkServiceRequest(httpMethod: .GET, endPoint: ""))
            if case .failure = result {
                XCTAssertFalse(mockCatService.isResponseSuccessfull)
            }
        }
    }
}
