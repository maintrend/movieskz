//
//  TabBarVC.swift
//  MoviesKZ
//
//  Created by talgat on 5/5/21.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

}
