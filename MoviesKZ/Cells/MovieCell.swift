//
//  MovieCell.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var voteAverageLabel: UILabel!
    
    func configure(with movie: Movie) {
        titleLabel.text = "Название: \(movie.title ?? "")"
        voteAverageLabel.text = "Рейтинг: \(movie.voteAverage ?? 0)"
    
        DispatchQueue.global().async {
            guard let posterPath = movie.posterPath else { return }
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: imageData)
            }
        }
    }
}
