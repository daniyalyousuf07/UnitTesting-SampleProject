//
//  CatService.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import Foundation

protocol CatServiceProtocol {
    var networkService: NetworkServiceProtocol { get }
    init(networkService:  NetworkServiceProtocol)
    func fetchCats(requestData: NetworkServiceRequestProtocol) async  -> Result<[CatBreedModel], NetworkError>
}

final class CatService: CatServiceProtocol {
    private(set) var networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol = NetworkService(urlSession: .shared,
                                                                          baseURL: "https://api.thecatapi.com/")) {
        self.networkService = networkService
    }
    
    func fetchCats(requestData: NetworkServiceRequestProtocol) async -> Result<[CatBreedModel], NetworkError> {
        let result: Result<[CatBreedModel], NetworkError> = await networkService.execute(requestData: requestData)
        return result
    }
}
