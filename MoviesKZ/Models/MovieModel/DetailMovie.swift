//
//  DetailMovie.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

struct DetailMovie: Decodable {
    let title: String?
    let releaseDate: String?
    let runTime: Int?
    let voteAverage: Double?
    let overview: String?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case runTime = "runtime"
        case voteAverage = "vote_average"
        case overview
        case genres = "genres"
    }
    
     func getGenresAsString() -> String? {
        guard let genres = genres else { return nil }
        var genresAsString = ""
        for index in genres.indices {
            genresAsString += genres[index].genreName.capitalized
            if index != genres.count - 1 {
                genresAsString += ", "
            }
        }
        return genresAsString
    }
}

