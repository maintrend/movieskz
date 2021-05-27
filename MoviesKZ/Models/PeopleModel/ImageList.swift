//
//  ImageList.swift
//  MoviesKZ
//
//  Created by talgat on 5/11/21.
//

struct ImageList: Decodable {
    let id: Int?
    let profiles: [ActorImageList]?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profiles = "profiles"
    }
    
    func getStringAsArray() -> String? {
        guard let imageString = profiles else {
            return nil
        }
//        var onlyArrayString: [String] = []
        var onlyArrayString = ""
        for index in imageString.indices {
            onlyArrayString += imageString[index].filePath
//            onlyArrayString.append("\(imageString[0].filePath)")
        }
        return onlyArrayString
    }
}
