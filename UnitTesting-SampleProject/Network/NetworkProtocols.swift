//
//  NetworkProtocols.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-29.
//

import Foundation

protocol NetworkServiceRequestProtocol {
    var queryParameters: [String: String]? { get }
    var bodyParameters: [String: String]? { get }
    var httpMethod: HttpMethods { get }
    var endPoint: String { get }
}

protocol NetworkServiceProtocol {
    var urlSession: URLSession { get }
    var baseURL: String{ get }
    init(urlSession: URLSession, baseURL: String)
    func execute<T: Decodable>(requestData: NetworkServiceRequestProtocol) async -> Result<T, NetworkError>
}
