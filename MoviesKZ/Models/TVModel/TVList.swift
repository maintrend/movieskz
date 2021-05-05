//
//  TVList.swift
//  MoviesKZ
//
//  Created by talgat on 5/2/21.
//



struct TVList: Decodable {
    let page, totalResults, totalPages: Int?
    let results: [TV]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
