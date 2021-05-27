//
//  ActorImageList.swift
//  MoviesKZ
//
//  Created by talgat on 5/11/21.
//

struct ActorImageList: Decodable {
    let filePath: String
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
    static func getImageActor(from imageList: ImageList) -> [ActorImageList]? {
        guard let photos = imageList.profiles  else { return nil }
        return photos
    }
}
