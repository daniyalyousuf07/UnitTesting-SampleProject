//
//  CatViewModel.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import Foundation

protocol CatViewModelProtocol {
    var isLoading: Bool { get }
    var cats: [CatBreedModel] { get }
    var catService: CatServiceProtocol { get }
    init(catService: CatServiceProtocol)
    func fetchCats(request: NetworkServiceRequestProtocol) async
}

class CatViewModel: CatViewModelProtocol {
    @Published var isLoading: Bool = true
    @Published var cats: [CatBreedModel] = []
    private(set) var catService: CatServiceProtocol
    
    required init(catService: CatServiceProtocol = CatService()) {
        self.catService = catService
    }
    
    @MainActor func fetchCats(request: NetworkServiceRequestProtocol =
                              NetworkServiceRequest(httpMethod: .GET,
                                                                                             endPoint: "/v1/breeds")) async {
        let result = await catService.fetchCats(requestData: request)
        isLoading = false
        if case let .success(model) = result {
            cats = model
        }
    }
}

extension CatViewModel: ObservableObject {}
