//
//  TrendingMapper.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 22/08/22.
//

import Foundation


struct TrendingMapper {
    static func mapTrendingData<T: Codable>(_ data: Data, model: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw DecodeError.errorWhileDecodingJson
        }
    }
}
