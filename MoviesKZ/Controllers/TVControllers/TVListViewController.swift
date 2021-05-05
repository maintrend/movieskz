//
//  TVListViewController.swift
//  MoviesKZ
//
//  Created by talgat on 4/30/21.
//

import UIKit

class TVListViewController: UITableViewController {

    var tvType: TVType!
    private var selectedTVid: Int!
    private var tvs: [TV] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APITVManager.fetchTVs(from: tvType) { (tvs, result) in
            switch result {
            case .Success:
                guard let tvs = tvs else { return }
                self.tvs = tvs
                DispatchQueue.main.async { //todo remove this main queue (try)
                    self.tableView.reloadData()
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tvs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TVCell
        let tv = tvs[indexPath.row]
        cell.configure(with: tv)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTVid = tvs[indexPath.row].id
        performSegue(withIdentifier: "GoToDetailTVViewController", sender: nil)
    }
    

    

    

    

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetailTVViewController" {
            let destinationVC = segue.destination  as! DetailTVViewController
            destinationVC.tvId = selectedTVid
        }
    }
    

}

