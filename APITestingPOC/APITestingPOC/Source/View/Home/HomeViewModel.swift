//
//  HomeViewModel.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 24/08/22.
//

import Foundation

class HomeViewModel {
    var homeEntity = HomeEntity()
    private let trendingService: TrendingServiceProtocol
    
    init(service: TrendingServiceProtocol) {
        self.trendingService = service
    }
    
    func loadTrendingMovies(completion: @escaping (Bool) -> Void) {
        trendingService.getTrending { [weak self] result in
            switch(result) {
                case .success(let data):
                    do {
                        let jsonData = try TrendingMapper.mapTrendingData(data, model: GeneralTrendingResponse.self)
                        self?.homeEntity.trendingData = jsonData
                        completion(true)
                    } catch {
                        if let jsonError = error as? DecodeError {
                            self?.homeEntity.error = jsonError.errorDescription
                            completion(false)
                        }
                    }
                case .failure(let error):
                    self?.homeEntity.error = error.localizedDescription
                    completion(false)
            }
        }
    }
}
