//
//  UserModel.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 14/08/22.
//

import Foundation

struct GeneralTrendingResponse: Codable {
    let page: Int
    let results: [TrendingModel]
    let totalPages, totalMedias: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalMedias = "total_results"
    }
}


struct TrendingModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let mediaType: MediaType?
    let name: String?
    let originCountry: [String]?
    let originalLanguage: OriginalLanguage?
    let originalName: String?
    let overview: String?
    let popularity: Double?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let title, originalTitle, releaseDate: String?
    let video: Bool?
    var posterPath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case title
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case video
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case es = "es"
    case de = "de"
    case fr = "fr"
    case zh = "zh"
    case unknown
    
    public init(from decoder: Decoder) throws {
         self = try OriginalLanguage(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
     }
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

