//
//  People.swift
//  MoviesKZ
//
//  Created by talgat on 5/9/21.
//


struct People: Decodable {
    let profilePath: String?
    let id: Int?
    let name: String?
    let popularity: Double?
//    let knownFor: [OneOf]?
    
    enum CodingKeys: String, CodingKey {
        case profilePath = "profile_path"
        case id = "id"
        case name = "name"
        case popularity = "popularity"
//        case knownFor = "known_for"
    }
    
    static func getPeoples(from peopleList: PeopleList) -> [People]? {
        return peopleList.results
    }
}
