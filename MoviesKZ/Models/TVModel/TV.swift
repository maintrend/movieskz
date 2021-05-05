//
//  TV.swift
//  MoviesKZ
//
//  Created by talgat on 5/2/21.
//

struct TV: Decodable {
    let posterPath: String?
    let id: Int?
    let backdropPath: String?
    let name: String?
    let voteAverage: Double?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case name
        case voteAverage = "vote_average"
        case overview
    }
    
    static func getTVs(from tvList: TVList) -> [TV]? {
        return tvList.results
    }
}
