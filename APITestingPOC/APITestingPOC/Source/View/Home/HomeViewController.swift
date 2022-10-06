//
//  ViewController.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 14/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeView: HomeView?
    private var homeViewModel: HomeViewModel
    var movieSelected = false
    
    init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() {
        self.homeView = HomeView(frame: UIScreen.main.bounds, entity: homeViewModel.homeEntity)
        self.view = self.homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView?.delegate = self
        homeViewModel.loadTrendingMovies { [weak self] success in
            if success {
                self?.homeView?.entity = self?.homeViewModel.homeEntity
            }
        }
    }
}


extension HomeViewController: HomeViewDelegate {
    func selectMovie(_ movie: TrendingModel) {
        movieSelected = true
    }
}

