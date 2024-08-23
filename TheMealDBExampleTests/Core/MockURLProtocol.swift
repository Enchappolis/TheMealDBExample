//
//  MockURLProtocol.swift
//  TheMealDBExampleTests
//
//  Created by Enchappolis on 8/20/24.
//

import Foundation
import XCTest

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: (() -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = MockURLProtocol.requestHandler else {
           XCTFail("Loading handler is not set.")
            return
        }
        
        let (response, data) = handler()
        
        // Tell the client that we have a response.
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        // If we have data, put it in the response.
        if let data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        // Inform the client that the process is complete and we have successfully created a response to our request.
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
