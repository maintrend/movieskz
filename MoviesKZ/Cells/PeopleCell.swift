//
//  PeopleCell.swift
//  MoviesKZ
//
//  Created by talgat on 5/9/21.
//

import UIKit

class PeopleCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var moviesListLabel: UILabel!
    
    func configure(with people: People) {
        nameLabel.text = "\(people.name ?? "")"
        DispatchQueue.global().async {
            guard let photoPath = people.profilePath else { return }
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(photoPath)") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.photoImageView.image = UIImage(data: imageData)
            }
        }
    }
}
