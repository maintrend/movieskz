//
//  PeopleDetailViewController.swift
//  MoviesKZ
//
//  Created by talgat on 5/11/21.
//

import UIKit

class PeopleDetailViewController: UIViewController {

    var peopleId: Int!
    var peopleDetail: PeopleDetail!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var placeBornLabel: UILabel!
    @IBOutlet weak var biographyTextView: UITextView!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var imageList: ImageList!
    var photoPeopleArray: [String] = ["1movie", "2movie", "3movie", "4movie"]
    var photoPeopleArray2: [ActorImageList] = []
    var photosActor: [String] = []
    var photosImageActor: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotosActor()
        getActorDetail()
    }
    
    private func configureUI() {
        nameLabel.text = peopleDetail.name ?? ""
        bornLabel.text = peopleDetail.birthday ?? ""
        deathLabel.text = peopleDetail.deathday ?? ""
        popularityLabel.text = "\(peopleDetail.popularity ?? 0)"
        placeBornLabel.text = peopleDetail.placeOfBirth ?? ""
        biographyTextView.text = peopleDetail.biography ?? ""
    }

    private func getActorDetail() {
        APIPeopleManager.fetchPeopleDetail(peopleId: peopleId) { (peopleListDetail, result) in
            switch result {
            case .Success:
                guard let peopleListDetail = peopleListDetail else { return }
                self.peopleDetail = peopleListDetail
                print("-------------------111111111-------")
                print(peopleListDetail)
                DispatchQueue.main.async {
                    self.configureUI()
                }
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in
                                                    self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    private func getPhotosActor() {
        APIPeopleManager.getPhotosActor(peopleId: peopleId) { (actorImageList, result) in
            switch result {
            case .Success:
                guard let actorImageList = actorImageList, actorImageList.count > 0 else { return }
                self.photoPeopleArray2 = actorImageList
                
                let urlsOnly = actorImageList.map { $0.filePath }
                
                let photoUrls = urlsOnly.map { "https://image.tmdb.org/t/p/w500\($0)" }

                self.photosActor = photoUrls
                self.downloadPhoto()

            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in
                                                self.navigationController?.popViewController(animated: true)
                })

                self.present(alert, animated: true, completion: nil)

            }
        }
    }
    func downloadPhoto(){
        DispatchQueue.global().async {
            self.photosImageActor.removeAll()

            for i in 0..<self.photosActor.count {
                guard let url = URL(string: self.photosActor[i]) else {
                    continue
                }

                let group = DispatchGroup()

                print(url)
                print("-------GROUP ENTER-------")

                group.enter()
                URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                    print(response?.suggestedFilename ?? url.lastPathComponent)

                    if let imgData = data, let image = UIImage(data: imgData) {
                        DispatchQueue.main.async() {
                            self.photosImageActor.append(image)
                            DispatchQueue.main.async{
                               self.photosCollectionView.reloadData()
                            }
                        }
                    } else if let error = error {
                        print(error)
                    }

                    group.leave()
                }).resume()

                group.wait()
            }
        }
    }

}

extension PeopleDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosImageActor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoPeopleCell
        cell.photoPeopleImageView.image = photosImageActor[indexPath.row]
//        cell.layer.cornerRadius = 10.0
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width - 40, height: 285)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
    }
    
}
