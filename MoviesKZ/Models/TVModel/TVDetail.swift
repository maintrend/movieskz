//
//  TVDetail.swift
//  MoviesKZ
//
//  Created by talgat on 5/3/21.
//

struct TVDetail: Decodable {
    let name: String?
    let firstAirDate: String?
    let episodeRunTime: [Int]?
    let voteAverage: Double?
    let overview: String?
    let genres: [TVGenre]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case firstAirDate = "first_air_date"
        case episodeRunTime = "episode_run_time"
        case voteAverage = "vote_average"
        case overview
        case genres = "genres"
    }
    
//    init(from decoder: Decoder) throws {
//        var container = try decoder.unkeyedContainer()
//        let values = try container.decode([Int].self)
//        self.episodeRunTime = values
//        self.name = ""
//        self.firstAirDate = ""
//        self.voteAverage = 0
//        self.overview = ""
//        self.genres = [TVGenre]()
//    }
    
    func getTVGenresAsString() -> String? {
       guard let genres = genres else { return nil }
       var genresAsString = ""
       for index in genres.indices {
        genresAsString += genres[index].genreTV.capitalized
           if index != genres.count - 1 {
               genresAsString += ", "
           }
       }
       return genresAsString
   }
}




