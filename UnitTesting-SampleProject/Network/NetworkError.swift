//
//  NetworkError.swift
//  UnitTesting-SampleProject
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidUrl(String?), genericError(String), decodingError(String?), invalidStatusCode(Int)
}

extension NetworkError {
    var errorDescription: String?  {
        switch self {
        case .decodingError(let error):
            return (error != nil) ? "Error: \(error!) while decoding" :  "Error while decoding"
        case .invalidStatusCode(let status):
            return "Invalid status code: \(status)"
        case .invalidUrl(let url):
            return (url != nil) ? "Invalid url: \(url!)" : "Invalid url"
        case .genericError(let error):
            return "\(error)"
        }
    }
}
