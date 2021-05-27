//
//  PeopleViewController.swift
//  MoviesKZ
//
//  Created by talgat on 5/8/21.
//

import UIKit

class PeopleViewController: UITableViewController {

    private var selectedPeopleId: Int!
    private var peoples: [People] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        APIPeopleManager.fetchPeople { (peoples, result) in
            switch result {
            case .Success:
                guard let peoples = peoples else { return }
                self.peoples = peoples
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
        return peoples.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PeopleCell
        let people = peoples[indexPath.row]
        cell.configure(with: people)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPeopleId = peoples[indexPath.row].id
        performSegue(withIdentifier: "toPeopleDetailSegue", sender: nil)
    }
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toPeopleDetailSegue" {
            let destVC = segue.destination as! PeopleDetailViewController
            destVC.peopleId = selectedPeopleId
        }
    }
    

}
