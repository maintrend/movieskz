//
//  DetailTVViewController.swift
//  MoviesKZ
//
//  Created by talgat on 4/30/21.
//

import UIKit
import WebKit
class DetailTVViewController: UIViewController {

    var tvId: Int!
    private var tv: TVDetail!
    private var tvReviewList: TVReviewList!
    private var addedToFavorite = false
    private var addedToWatchLater = false
    
    @IBOutlet weak var trailerPlayer: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseGenreLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var watchLaterButton: UIButton!
    @IBOutlet weak var overviewReviewSC: UISegmentedControl!
    @IBOutlet weak var overviewReviewTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTVDetailedInfo()
        getTVTrailer()
        getTVReviews()
    }
    
    private func configureUI() {
        titleLabel.text = tv.name ?? ""
        releaseGenreLabel.text = (tv.firstAirDate ?? "") + ", " + (tv.getTVGenresAsString() ?? "")
        if let runTime = tv.episodeRunTime {
            runTimeLabel.text = "53 мин"
        } else {
            runTimeLabel.text = ""
        }
        voteAverageLabel.text = "\(tv.voteAverage ?? 0)"
        overviewReviewTV.text = tv.overview ?? ""
    }
    
    private func getTVDetailedInfo() {
        APITVManager.fetchDetailTV(tvId: tvId) { (detailTV, result) in
            switch result {
            case .Success:
                guard let detailTV = detailTV else { return }
                self.tv = detailTV
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
    
    private func getTVTrailer() {
        APITVManager.fetchTVTrailer(tvId: tvId) { (trailers, result) in
            switch result {
            case .Success:
                guard let trailers = trailers, trailers.count > 0 else {
                    let alert = UIHelpers.showAlert(withTitle: "Трейлер отсутствует",
                                                    message: "Не удалось загрузить трейлер",
                                                    buttonTitle: "Хорошо",
                                                    handler: nil)
                    self.present(alert, animated: true, completion: nil)
                    return }
                guard let videoCode = trailers[0].key else { return }
                DispatchQueue.main.async {
                    guard let url = URL(string: "https://www.youtube.com/embed/\(videoCode)") else { return }
                    self.trailerPlayer.load(URLRequest(url: url))
                }
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in                                        self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    private func getTVReviews() {
        APITVManager.fetchTVReviews(tvId: tvId) { (reviewlist, result) in
            switch result {
            case .Success:
                guard let reviewList = reviewlist else { return }
                self.tvReviewList = reviewList
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in                                        self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func addToFavoritePressed(_ sender: UIButton) {
        if addedToFavorite {
            addToFavoriteButton.setImage(UIImage(named: "heart"), for: .normal)
            addToFavoriteButton.setTitle(" Добавить в избранное", for: .normal)
        } else {
            addToFavoriteButton.setImage(UIImage(named: "heartColored"), for: .normal)
            addToFavoriteButton.setTitle(" В избранном", for: .normal)
        }
        addedToFavorite = !addedToFavorite
    }
    
    
    @IBAction func watchLaterPressed(_ sender: UIButton) {
        if addedToWatchLater {
            watchLaterButton.setImage(UIImage(named: "bookmark"), for: .normal)
            watchLaterButton.setTitle(" Смотреть позже", for: .normal)
        } else {
            watchLaterButton.setImage(UIImage(named: "bookmarkSelected"), for: .normal)
            watchLaterButton.setTitle(" Посмотрю позже", for: .normal)
        }
        addedToWatchLater = !addedToWatchLater
    }
    
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            overviewReviewTV.text = tv.overview
        } else if sender.selectedSegmentIndex == 1 {
            overviewReviewTV.text = tvReviewList.getReviewAsString()
        } else if sender.selectedSegmentIndex == 2 {
            overviewReviewTV.text = "Сервис временно недоступен"
        } else {
            overviewReviewTV.text = "Сервис временно недоступен"
        }
    }
}
