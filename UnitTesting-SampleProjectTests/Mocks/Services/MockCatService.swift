//
//  MockCatService.swift
//  UnitTesting-SampleProjectTests
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import Foundation
@testable import UnitTesting_SampleProject

class MockCatService: CatServiceProtocol {
  
    var isFetchCatsMethodCalled: Bool!
    var isResponseSuccessfull: Bool = true
    
    var networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol = NetworkService(urlSession: .shared, baseURL: "")) {
        self.networkService = networkService
    }
    
    func fetchCats(requestData: NetworkServiceRequestProtocol) async -> Result<[CatBreedModel], NetworkError> {
        isFetchCatsMethodCalled = true
        if isResponseSuccessfull {
            return .success([])
        } else {
            return .failure(.invalidUrl(nil))
        }
    }
}
