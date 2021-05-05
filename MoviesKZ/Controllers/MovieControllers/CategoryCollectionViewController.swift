//
//  CategoryCollectionViewController.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

import UIKit

enum UserAction: String, CaseIterable {
    case topRatedMovies = "Лучшие"
    case popularMovies = "Популярные"
    case upcomingMovies = "Ожидаемые"
    case nowPlayingMovies = "Смотрят сейчас"
}

class CategoryCollectionViewController: UICollectionViewController {
    
    private var userAction: UserAction!
    private let userActions = UserAction.allCases
    private let reuseIdentifier = "CategoryCell"

    let imageCollectionCell: [UIImage] = [
        UIImage(named: "1movie")!,
        UIImage(named: "2movie")!,
        UIImage(named: "3movie")!,
        UIImage(named: "4movie")!,
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let moviesListVC = segue.destination as! MoviesListViewController
            switch userAction! {
            case .topRatedMovies:
                moviesListVC.movieType = .topRated
            case .popularMovies:
                moviesListVC.movieType = .popular
            case .upcomingMovies:
                moviesListVC.movieType = .upComing
            case .nowPlayingMovies:
                moviesListVC.movieType = .nowPlaying
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        cell.imageCell.image = imageCollectionCell[indexPath.item]
        cell.layer.cornerRadius = 15
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userAction = userActions[indexPath.item]
        performSegue(withIdentifier: "ShowMovies", sender: nil)
    }
    
}

