//
//  UpcomingMapper.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 22/08/22.
//

import Foundation

struct UpcomingMapper {
    static func mapUpcomingData(_ data: Data) throws -> GeneralUpcomingResponse {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options:  []) as! NSDictionary
            return GeneralUpcomingResponse.from(json)!
        } catch {
            throw error
        }
    }
}
