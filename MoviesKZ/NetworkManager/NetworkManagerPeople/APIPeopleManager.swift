//
//  APIPeopleManager.swift
//  MoviesKZ
//
//  Created by talgat on 5/9/21.
//

import Foundation

final class APIPeopleManager {
    
    let apiKey = "10c9d0f7d2e89b09263bafaaf8c69a6a"
    
    static func fetchPeople(completionHandler: @escaping ([People]?, APIResult) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=10c9d0f7d2e89b09263bafaaf8c69a6a&language=en-US&page=1") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let peopleList = try JSONDecoder().decode(PeopleList.self, from: data)
                let peoples = People.getPeoples(from: peopleList)
                
                guard peoples != nil else {
                    completionHandler(nil, .Failure)
                    return
                }
                
                completionHandler(peoples, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
    
    static func fetchPeopleDetail(peopleId: Int, completionHandler: @escaping (PeopleDetail?, APIResult) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(peopleId)?api_key=10c9d0f7d2e89b09263bafaaf8c69a6a&language=en-US") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let peopleListDetail = try JSONDecoder().decode(PeopleDetail.self, from: data)
                completionHandler(peopleListDetail, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
    
    static func getPhotosActor(peopleId: Int, completionHandler: @escaping ([ActorImageList]?, APIResult) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(peopleId)/images?api_key=10c9d0f7d2e89b09263bafaaf8c69a6a") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let actorList = try JSONDecoder().decode(ImageList.self, from: data)
                let photos = ActorImageList.getImageActor(from: actorList)
                
                guard photos != nil else {
                    completionHandler(nil, .Failure)
                    return
                }
                
                completionHandler(photos, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
    
}
