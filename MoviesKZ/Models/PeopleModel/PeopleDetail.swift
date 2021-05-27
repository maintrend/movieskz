//
//  PeopleDetail.swift
//  MoviesKZ
//
//  Created by talgat on 5/11/21.
//

struct PeopleDetail: Decodable {
    let birthday: String?
    let deathday: String?
    let id: Int?
    let name: String?
    let biography: String?
    let popularity: Double?
    let placeOfBirth: String?
    enum CodingKeys: String, CodingKey {
        case birthday = "birthday"
        case deathday = "deathday"
        case id = "id"
        case name = "name"
        case biography = "biography"
        case popularity = "popularity"
        case placeOfBirth = "place_of_birth"
    }
}
