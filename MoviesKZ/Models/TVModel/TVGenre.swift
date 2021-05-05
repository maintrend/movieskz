//
//  TVGenre.swift
//  MoviesKZ
//
//  Created by talgat on 5/3/21.
//


struct TVGenre: Decodable {
    let genreTV: String
    
    enum CodingKeys: String, CodingKey {
        case genreTV = "name"
    }
}
