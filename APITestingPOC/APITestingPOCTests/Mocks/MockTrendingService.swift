//
//  MockTrendingService.swift
//  APITestingPOCTests
//
//  Created by Thiago Henrique on 14/08/22.
//

import Foundation
@testable import APITestingPOC

class MockTrendingService {
    var shouldReturnError = false
    var shouldReturnJsonError = false
    var getTrendingWasCalled = false
    
    enum MockTrendingError: Error {
        case getTrending
    }
    
    func reset() {
        shouldReturnError = false
        getTrendingWasCalled = false
    }
}

extension MockTrendingService: TrendingServiceProtocol {
    func getTrending(completion: @escaping (Result<Data, HTTPError>) -> Void) {
        getTrendingWasCalled = true
        
        if shouldReturnError {
            completion(.failure(HTTPError.serverSideError(0)))
        } else {
            guard let url = Bundle(
                for: MockTrendingService.self).url (
                    forResource: shouldReturnJsonError ? "BadTrendingJsonResponse" : "TrendingJsonResponse",
                    withExtension: "json"
                ),
                  let data = try? Data(contentsOf: url)
            else { return }
            
            completion(.success(data))
        }
    }
}
