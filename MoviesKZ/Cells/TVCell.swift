//
//  TVCell.swift
//  MoviesKZ
//
//  Created by talgat on 5/2/21.
//

import UIKit

class TVCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var voteAverageLabel: UILabel!

    func configure(with tv: TV) {
        titleLabel.text = "Название: \(tv.name ?? "")"
        voteAverageLabel.text = "Рейтинг: \(tv.voteAverage ?? 0)"
        
        DispatchQueue.global().async {
            guard let posterPath = tv.posterPath else {return}
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl)
            else {return}
            
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: imageData)
            }
        }
    }
}
