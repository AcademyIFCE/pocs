//
//  HomeControllerTest.swift
//  APITestingPOCTests
//
//  Created by Thiago Henrique on 31/08/22.
//

import XCTest
@testable import APITestingPOC

class HomeControllerTest: XCTestCase {
    var mockTrendingService: MockTrendingService!
    var viewModel: HomeViewModel!
    var homeController: HomeViewController!
    var homeView: HomeView!
    		
    override func setUp() {
        mockTrendingService = MockTrendingService()
        viewModel = HomeViewModel(service: mockTrendingService)
        homeController = HomeViewController(viewModel: viewModel)
        homeView = HomeView(frame: .zero, entity: viewModel.homeEntity)
        
        homeView.delegate = homeController
    }
    
    func test_selectMovie_shouldBe_selected() {
        mockTrendingService.getTrending { [weak self] result in
            switch(result) {
                case.success(let data):
                    //given
                    let mockedTrendingTest = try! TrendingMapper.mapTrendingData(data, model: GeneralTrendingResponse.self)
                    self?.homeView?.delegate?.selectMovie(mockedTrendingTest.results.first!)
                    //then
                    let movieSelected = self?.homeController.movieSelected
                    //when
                    XCTAssertNotNil(movieSelected)
                    XCTAssertTrue(movieSelected!)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
            }
        }
    }
}
