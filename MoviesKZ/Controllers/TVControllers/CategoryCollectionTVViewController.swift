//
//  CategoryCollectionTVViewController.swift
//  MoviesKZ
//
//  Created by talgat on 4/30/21.
//

import UIKit


enum UserActionTV: String, CaseIterable {
    case tvAiringToday = "В эфире сегодня"
    case tvOnTheAir = "По телевидению"
    case tvPopular = "Популярные"
    case tvTopRated = "Лучшие"
}


class CategoryCollectionTVViewController: UICollectionViewController {
    var userActionTV: UserActionTV!
    var userActionsTV = UserActionTV.allCases
    private let reuseIdentifier = "CategoryCellTV"
    let imageTVCV: [UIImage] = [
        UIImage(named: "1tv")!,
        UIImage(named: "2tv")!,
        UIImage(named: "3tv")!,
        UIImage(named: "4tv")!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tvListVC = segue.destination as! TVListViewController
        switch userActionTV! {
        case .tvAiringToday:
            tvListVC.tvType = .airingToday
        case .tvOnTheAir:
            tvListVC.tvType = .onTheAir
        case .tvPopular:
            tvListVC.tvType = .popular
        case .tvTopRated:
            tvListVC.tvType = .topRated
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userActionsTV.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        as! CategoryCellTV
        cell.userActionTVLabel.text = userActionsTV[indexPath.item].rawValue
        cell.imageTVCell.image = imageTVCV[indexPath.item]
        cell.layer.cornerRadius = 15
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userActionTV = userActionsTV[indexPath.item]
        performSegue(withIdentifier: "ShowTVs", sender: nil)
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
