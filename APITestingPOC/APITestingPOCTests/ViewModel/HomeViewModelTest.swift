//
//  HomeViewModelTest.swift
//  APITestingPOCTests
//
//  Created by Thiago Henrique on 31/08/22.
//

import XCTest
@testable import APITestingPOC

class HomeViewModelTest: XCTestCase {
    var mockTrendingService: MockTrendingService!
    var viewModel: HomeViewModel!
    
    override func setUp() {
        mockTrendingService = MockTrendingService()
        viewModel = HomeViewModel(service: mockTrendingService)
    }
    
    func test_getTrending_should_callService() {
        //given
        viewModel.loadTrendingMovies { result in
            XCTAssertTrue(result)
        }
        //then
        let hasCalled = mockTrendingService.getTrendingWasCalled
        //when
        XCTAssertTrue(hasCalled)
    }
    
    func test_getTrending_shouldBe_error() {
        //given
        mockTrendingService.shouldReturnError = true
        viewModel.loadTrendingMovies { result in
            XCTAssertFalse(result)
        }
        //then
        
        //when
        XCTAssertNotNil(viewModel.homeEntity.error)
    }
    
    func test_getTrending_shouldBe_valid() {
        //given
        viewModel.loadTrendingMovies { result in
            XCTAssertTrue(result)
        }
        //then
        let entity = viewModel.homeEntity
        //when
        XCTAssertNotNil(entity.trendingData?.results)
    }
}
