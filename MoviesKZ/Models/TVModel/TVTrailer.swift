//
//  TVTrailer.swift
//  MoviesKZ
//
//  Created by talgat on 5/2/21.
//

struct TVTrailer: Decodable {
    let key: String?
    
    static func getTVTrailers(from tvTrailerList: TVTrailerList) -> [TVTrailer]? {
        guard let tvTrailer = tvTrailerList.results else {
            return nil
        }
        return tvTrailer
    }
}
