//
//  PeopleList.swift
//  MoviesKZ
//
//  Created by talgat on 5/9/21.
//

struct PeopleList: Decodable {
    let page, totalResults, totalPages: Int?
    let results: [People]?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}
