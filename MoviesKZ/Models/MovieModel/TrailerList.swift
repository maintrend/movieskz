//
//  TrailerList.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//


struct TrailerList: Decodable {
    let id: Int?
    let results: [Trailer]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}
