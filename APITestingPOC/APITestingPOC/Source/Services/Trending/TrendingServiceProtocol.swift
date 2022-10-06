//
//  UserServiceProtocol.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 14/08/22.
//

import Foundation

protocol TrendingServiceProtocol {
    func getTrending(completion: @escaping (Result<Data, HTTPError>) -> Void)
}
