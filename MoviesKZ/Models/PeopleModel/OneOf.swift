//
//  OneOf.swift
//  MoviesKZ
//
//  Created by talgat on 5/9/21.
//

enum MediaType: String, Decodable {
    case tv, movie
}

enum OneOf: Decodable{
    case movie(Movie), tv(TV)
    
    private enum CodingKeys: String, CodingKey{
        case mediaType
    }
    init(from decoder : Decoder) throws {
            let dictionaryContainer = try decoder.container(keyedBy: CodingKeys.self)
            let mediaType = try dictionaryContainer.decode(MediaType.self, forKey: .mediaType)
            let container = try decoder.singleValueContainer()
            switch mediaType {
                case .tv: self = .tv(try container.decode(TV.self))
                case .movie: self = .movie(try container.decode(Movie.self))
            }
        }
}

// select between two struct
// https://stackoverflow.com/questions/60633154/swift-error-keynotfoundcodingkeysstringvalue-adult-intvalue-nil



