//
//  Trailer.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

struct Trailer: Decodable {
    let key: String?
    
    static func getTrailers(from trailerList: TrailerList) -> [Trailer]? {
        guard let trailer = trailerList.results else { return nil }
        return trailer
    }
}
