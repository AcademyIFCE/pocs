//
//  HomeEntity.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 29/08/22.
//

import Foundation

struct HomeEntity {
    var loading = false
    var trendingData: GeneralTrendingResponse?
    var error: String?
}
