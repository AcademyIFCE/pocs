//
//  UserService.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 14/08/22.
//

import Foundation

struct TrendingService: TrendingServiceProtocol {
    
    func getTrending(completion: @escaping (Result<Data, HTTPError>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(HTTPError.transportError(error!)))
                return
            }
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completion(.failure(HTTPError.serverSideError(status)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }

}

