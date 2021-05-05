//
//  WelcomeViewController.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    private var isSignInClicked = false
    
    
    @IBAction func signInUpButton(_ sender: UIButton) {
        
        switch sender.tag {
               case 0:
                   isSignInClicked = true
                   performSegue(withIdentifier: "ShowSignInUpVC", sender: self)
               case 1:
                   isSignInClicked = false
                   performSegue(withIdentifier: "ShowSignInUpVC", sender: self)
               default:
                   print("Another button was clicked")
               }
    }
    //    @IBAction func signInUpButton(_ sender: UIButton) {
//
//        switch sender.tag {
//        case 0:
//            isSignInClicked = true
//            performSegue(withIdentifier: "ShowSignInUpVC", sender: self)
//        case 1:
//            isSignInClicked = false
//            performSegue(withIdentifier: "ShowSignInUpVC", sender: self)
//        default:
//            print("Another button was clicked")
//        }
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSignInUpVC" {
            let destinationVC = segue.destination as! SignInUpViewController
            destinationVC.isSignInClicked = isSignInClicked
        }
    }
}
