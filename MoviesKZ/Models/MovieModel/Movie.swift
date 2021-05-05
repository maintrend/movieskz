//
//  Movie.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

struct Movie: Decodable {
    let posterPath: String?
    let id: Int?
    let backdropPath: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case voteAverage = "vote_average"
        case overview
    }
    
    static func getMovies(from movieList: MovieList) -> [Movie]? {
        return movieList.results
    }
}
