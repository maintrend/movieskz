//
//  TVReview.swift
//  MoviesKZ
//
//  Created by talgat on 5/3/21.
//

struct TVReview: Decodable {
    let content: String
    
    static func getTVReviews(from tvReviewList: TVReviewList) -> [TVReview]? {
        guard let tvReviews = tvReviewList.results else {
            return nil
        }
        return tvReviews
    }
}
