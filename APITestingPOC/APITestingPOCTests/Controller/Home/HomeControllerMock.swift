//
//  HomeControllerMock.swift
//  APITestingPOCTests
//
//  Created by Thiago Henrique on 31/08/22.
//

import Foundation
@testable import APITestingPOC

class MockHomeController: HomeViewDelegate {
    var movieSelected = false
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    func selectMovie(_ movie: TrendingModel) {
        self.movieSelected = true
    }
}
