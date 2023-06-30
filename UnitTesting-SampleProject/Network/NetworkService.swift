//
//  NetworkService.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import Foundation

struct NetworkServiceRequest: NetworkServiceRequestProtocol {
    var queryParameters: [String : String]?
    var bodyParameters: [String : String]?
    var httpMethod: HttpMethods
    var endPoint: String
}


struct NetworkService: NetworkServiceProtocol {
    private(set) var urlSession: URLSession
    private(set) var baseURL: String
    init(urlSession: URLSession, baseURL: String) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
}
