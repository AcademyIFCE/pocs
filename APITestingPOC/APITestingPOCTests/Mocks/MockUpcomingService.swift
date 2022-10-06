//
//  MockUpcomingService.swift
//  APITestingPOCTests
//
//  Created by Thiago Henrique on 22/08/22.
//

import Foundation
@testable import APITestingPOC

class MockUpcomingService {
    var shouldReturnError = false
    var getUpcomingWasCalled = false
    
    enum MockUpcomingError: Error {
        case getUpcoming
    }
    
    func reset() {
        shouldReturnError = false
        getUpcomingWasCalled = false
    }
}

extension MockUpcomingService: UpcomingServiceProtocol {
    func getUpcomingMovies(completion: @escaping (Result<Data, Error>) -> Void) {
        getUpcomingWasCalled = true
        
        if shouldReturnError {
            completion(.failure(MockUpcomingError.getUpcoming))
        } else {
            guard let url = Bundle(
                for: MockTrendingService.self).url (
                    forResource: "UpcomingJsonResponse",
                    withExtension: "json"
                ),
                  let data = try? Data(contentsOf: url)
            else { return }
            
            completion(.success(data))
        }
    }
}
