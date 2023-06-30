//
//  Service.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import Foundation

extension NetworkService {
    func execute<T: Decodable>(requestData: NetworkServiceRequestProtocol) async -> Result<T, NetworkError> {
        
        let token: String? = nil //get it from keychain
        
        guard let url = URL(string: baseURL + requestData.endPoint) else {
            return  .failure(.invalidUrl(baseURL + requestData.endPoint))
        }
        
        var urlComponent =  URLComponents(string: url.absoluteString)
        if let queryParameters = requestData.queryParameters {
            urlComponent?.queryItems = queryParameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = urlComponent?.url else {
            return .failure(.invalidUrl(urlComponent?.url?.absoluteString))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestData.httpMethod.rawValue
        
        if let token = token {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.allHTTPHeaderFields = ["Authorization":  "Bearer \(token)"]
        }
        
        if let bodyParameters = requestData.bodyParameters {
            guard let data = try? JSONEncoder().encode(bodyParameters) else {
                return .failure(.decodingError(nil))
            }
            request.httpBody = data
        }
        
        do {
            let result = try await urlSession.data(for: request)
            if let response = result.1 as? HTTPURLResponse, !((200...300) ~= response.statusCode) {
                return .failure(.invalidStatusCode(response.statusCode))
            }
            else if result.0.isEmpty {
                return .failure(.genericError("Data is empty"))
            }
            guard let decodable = try? JSONDecoder().decode(T.self, from: result.0) else {
                return .failure(.decodingError(nil))
            }
            return .success(decodable)
        } catch {
            return .failure(.genericError(error.localizedDescription))
        }
    }
}
