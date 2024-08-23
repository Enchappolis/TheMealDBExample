//
//  NetworkManagerTesting.swift
//  TheMealDBExampleTests
//
//  Created by Enchappolis on 8/21/24.
//

import Foundation
import XCTest
@testable import TheMealDBExample

// Creates a network manager that uses mock data.
class NetworkManagerTesting: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    override func setUpWithError() throws {
        url = URL(string: "https://themealdb.com/api/json/v1/1")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        session = nil
        url = nil
    }
    
    func getMockNetworkManagerUsingDataFrom(file: String, withStatusCode: Int = 200) throws -> NetworkManagerProtocol? {
        
        let data = try MockData.getDataFrom(fileName: file)
        
        MockURLProtocol.requestHandler = {
            
            let response = HTTPURLResponse(url: self.url, statusCode: withStatusCode, httpVersion: nil, headerFields: nil)
            
            return (response!, data)
        }
        
        let networkManager = NetworkManager.shared(urlSession: session)
        
        return networkManager
    }
}
