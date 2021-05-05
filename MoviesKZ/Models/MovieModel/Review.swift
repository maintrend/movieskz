//
//  Review.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

struct Review: Decodable {
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case content
    }
    
    static func getReviews(from reviewList: ReviewList) -> [Review]? {
        guard let reviews = reviewList.results else { return nil }
        return reviews
    }
}
