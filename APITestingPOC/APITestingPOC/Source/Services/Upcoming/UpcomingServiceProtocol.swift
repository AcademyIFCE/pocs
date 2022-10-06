//
//  UpcomingServiceProtocol.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 22/08/22.
//

import Foundation

protocol UpcomingServiceProtocol {
    func getUpcomingMovies(completion: @escaping (Result<Data, Error>) -> Void)
}
