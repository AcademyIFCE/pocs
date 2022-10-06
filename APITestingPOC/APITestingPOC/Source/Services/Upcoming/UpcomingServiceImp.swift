//
//  UpcomingServiceImp.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 22/08/22.
//

import Foundation

struct UpcomingService: UpcomingServiceProtocol {
    
    func getUpcomingMovies(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
