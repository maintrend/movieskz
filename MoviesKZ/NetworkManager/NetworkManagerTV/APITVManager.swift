//
//  APITVManager.swift
//  MoviesKZ
//
//  Created by talgat on 5/2/21.
//

import Foundation

final class APITVManager {
    let apiKey = "10c9d0f7d2e89b09263bafaaf8c69a6a"
    
    static func fetchTVs(from tvType: TVType, completionHandler: @escaping ([TV]?, APIResult) -> Void) {
        
        URLSession.shared.dataTask(with: tvType.request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let tvList = try JSONDecoder().decode(TVList.self, from: data)
                let tvs = TV.getTVs(from: tvList)
                
                guard tvs != nil else {
                    completionHandler(nil, .Failure)
                    return
                }
                
                completionHandler(tvs, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            
            }.resume()
    }
    
    static func fetchTVTrailer(tvId: Int, completionHandler: @escaping ([TVTrailer]?, APIResult) -> Void) {
        
        guard let url = URL(string: BaseTVApiData.baseURL + "/\(tvId)/videos" + BaseTVApiData.apiKey + "&language=en-US") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let trailerTVList = try JSONDecoder().decode(TVTrailerList.self, from: data)
                let trailers = TVTrailer.getTVTrailers(from: trailerTVList)
                
                guard trailers != nil else {
                    completionHandler(nil, .Failure)
                    return
                }
                
                completionHandler(trailers, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
    
    static func fetchTVReviews(tvId: Int, completionHandler: @escaping (TVReviewList?, APIResult) -> Void) {
        
        guard let url = URL(string: BaseTVApiData.baseURL + "/\(tvId)/reviews" + BaseTVApiData.apiKey + "&language=en-US") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let reviewTVList = try JSONDecoder().decode(TVReviewList.self, from: data)
                completionHandler(reviewTVList, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
    
    static func fetchDetailTV(tvId: Int, completionHandler: @escaping (TVDetail?, APIResult) -> Void) {
        
        guard let url = URL(string: BaseTVApiData.baseURL + "/\(tvId)" + BaseTVApiData.apiKey + "&language=en-US") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            do {
                let detailTV = try JSONDecoder().decode(TVDetail.self, from: data)
                completionHandler(detailTV, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
    
}
