//
//  APITestingPOCTests.swift
//  APITestingPOCTests
//
//  Created by Thiago Henrique on 14/08/22.
//

import XCTest
@testable import APITestingPOC

class APITestingPOCTests: XCTestCase {
    let trendingService = MockTrendingService()
    let upcomingService = MockUpcomingService()
    
    func test_getAllTrending_shouldBe_Valid() async {
        let expectation = self.expectation(description: "Sucessfully return all trending movies")
        
        trendingService.getTrending { result in
            switch(result){
                case.success(let data):
                    do {
                        let trendingMovies = try TrendingMapper.mapTrendingData(data, model: GeneralTrendingResponse.self)
                        XCTAssertNotNil(trendingMovies)
                        expectation.fulfill()
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                case.failure(let error):
                    XCTFail(error.localizedDescription)
            }
            
        }
        
        await self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func test_getAllTrending_shouldBe_jsonError() async {
        let expectation = self.expectation(description: "Return a json error in decode process")
        trendingService.shouldReturnJsonError = true
        
        trendingService.getTrending { result in
            switch(result){
                case.success(let data):
                    do {
                        let _ = try TrendingMapper.mapTrendingData(data, model: GeneralTrendingResponse.self)
                        XCTFail()
                    } catch {
                        let validError = error as? DecodeError
                        XCTAssertNotNil(validError)
                        XCTAssertEqual(validError, DecodeError.errorWhileDecodingJson)
                        expectation.fulfill()
                    }
                case.failure(let error):
                    XCTFail(error.localizedDescription)
            }
            
        }
        
        await self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
