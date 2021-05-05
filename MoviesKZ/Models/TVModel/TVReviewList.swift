//
//  TVReviewList.swift
//  MoviesKZ
//
//  Created by talgat on 5/3/21.
//

struct TVReviewList: Decodable {
    let id: Int?
    let page: Int?
    let results: [TVReview]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case page
        case results
    }
    
    func getReviewAsString() -> String? {
        guard let reviews = results, reviews.isEmpty == false else { return nil }
        var reviewsAsString = ""
        for index in reviews.indices {
            reviewsAsString += "\(index + 1). \(reviews[index].content)\n\n"
        }
        return reviewsAsString
    }
}
