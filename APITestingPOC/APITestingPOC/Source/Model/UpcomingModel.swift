//
//  UpcomingModel.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 22/08/22.
//

import Foundation
import Mapper

struct GeneralUpcomingResponse: Mappable {
    let dates: Dates
    let page: Int
    let results: [Upcoming]
    let totalPages, totalResults: Int
    
    init(map: Mapper) throws {
        dates = try map.from("dates")
        page = try map.from("page")
        results = try map.from("results")
        totalPages = try map.from("total_pages")
        totalResults = try map.from("total_results")
    }
}

struct Upcoming: Mappable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle: String?
    let overview: String?
    let popularity: Double?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var posterPath: String?
    
    init(map: Mapper) throws {
        adult = try map.from("adult")
        backdropPath = try map.from("backdrop_path")
        genreIDS = try map.from("genre_ids")
        id = try map.from("id")
        originalLanguage = try map.from("original_language")
        originalTitle = try map.from("original_title")
        overview = try map.from("overview")
        popularity = try map.from("popularity")
        posterPath = try map.from("poster_path")
        releaseDate = try map.from("release_date")
        title = try map.from("title")
        video = try map.from("video")
        voteAverage = try map.from("vote_avarage")
        voteCount = try map.from("vote_count")
    }
}


struct Dates: Mappable {
    let maximum, minimum: String
    
    init(map: Mapper) throws {
        maximum = try map.from("maximum")
        minimum = try map.from("minimum")
    }
}
