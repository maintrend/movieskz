//
//  MovieList.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

struct MovieList: Decodable {
    let page, totalResults, totalPages: Int?
    let results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
