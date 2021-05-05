//
//  ReviewList.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

struct ReviewList: Decodable {
    let id: Int?
    let page: Int?
    let results: [Review]?
    
    func getReviewAsString() -> String? {
        guard let reviews = results, reviews.isEmpty == false else { return nil }
        var reviewsAsString = ""
        for index in reviews.indices {
            reviewsAsString += "\(index + 1). \(reviews[index].content)\n\n"
        }
        return reviewsAsString
    }
}
