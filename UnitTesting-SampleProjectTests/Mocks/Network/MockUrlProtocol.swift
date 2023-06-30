//
//  MockUrlProtocol.swift
//  UnitTesting-SampleProjectTests
//
//  Created by Daniyal Yousuf on 2023-06-28.
//

import Foundation

class MockUrlProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse,  Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func stopLoading() {

    }
    
    override func startLoading() {
        guard let handler = MockUrlProtocol.requestHandler else {
            return
        }
        
        do {
            let (response, data)  = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}
