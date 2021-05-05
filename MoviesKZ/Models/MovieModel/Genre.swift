//
//  Genre.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

struct Genre: Decodable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "name"
    }
}
