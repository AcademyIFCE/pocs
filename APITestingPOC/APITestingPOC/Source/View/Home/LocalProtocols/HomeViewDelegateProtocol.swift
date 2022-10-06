//
//  HomeViewProtocol.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 29/08/22.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func selectMovie(_ movie: TrendingModel)
}
