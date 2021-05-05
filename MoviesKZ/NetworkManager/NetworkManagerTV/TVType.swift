//
//  TVType.swift
//  MoviesKZ
//
//  Created by talgat on 4/30/21.
//

import Foundation

enum TVType {
    case airingToday
    case onTheAir
    case popular
    case topRated
    
    var otherParameters: String {
        return "&language=ru&page=1"
    }
    
    var path: String {
        switch self {
        case .airingToday:
            return "/airing_today"
        case .onTheAir:
            return "/on_the_air"
        case .popular:
            return "/popular"
        case .topRated:
            return "/top_rated"
        }
    }
    
    var request: URLRequest {
        guard let url = URL(string: BaseTVApiData.baseURL + path + BaseTVApiData.apiKey + otherParameters) else {
            fatalError("URL was not created")
        }
        return URLRequest(url: url)
    }
}
