//
//  MovieType.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

import Foundation

enum MovieType {
    
    case topRated
    case popular
    case upComing
    case nowPlaying
    
    var otherParameters: String {
        return "&language=ru&page=1"
    }
    
    var path: String {
        switch self {
        case .topRated:
            return "/top_rated"
        case .popular:
            return "/popular"
        case .upComing:
            return "/upcoming"
        case .nowPlaying:
            return "/now_playing"
        }
    }
    
    var request: URLRequest {
        guard let url = URL(string: BaseApiData.baseURL + path + BaseApiData.apiKey + otherParameters) else {
            fatalError("URL was not created")
        }
        return URLRequest(url: url)
    }
}
