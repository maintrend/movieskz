//
//  TVTrailerList.swift
//  MoviesKZ
//
//  Created by talgat on 5/2/21.
//

struct TVTrailerList: Decodable {
    let id: Int?
    let results: [TVTrailer]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}

