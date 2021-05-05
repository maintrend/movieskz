//
//  SignInUpViewController.swift
//  MoviesKZ
//
//  Created by talgat on 4/28/21.
//

import UIKit

class SignInUpViewController: UIViewController {
    
    private var user: User!
    
    var isSignInClicked: Bool!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var sigInUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Введите логин",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemOrange])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Введите пароль",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemOrange])
        setUpViewController()
    }
    
    private func setUpViewController() {
        
        sigInUpButton.setTitle(isSignInClicked ? "Войти" : "Зарегистрироваться", for: .normal)
        
    }
    
    private func verifyLoginPasswordFields() -> (login: String, password: String)? {
        
        guard let login = loginTextField.text, !(login.isEmpty) else {
            showAlert(withTitle: "Ошибка",
                      message: "Имя пользователя не может быть пустым",
                      buttonTitle: "Хорошо",
                      handler: nil)
            return nil
        }
        
        guard let password = passwordTextField.text, !(password.isEmpty) else {
            showAlert(withTitle: "Ошибка",
                      message: "Пароль не может быть пустым",
                      buttonTitle: "Хорошо",
                      handler: nil)
            return nil
        }
        
        if let _ = Double(login) {
            showAlert(withTitle: "Ошибка",
                      message: "Логин неможет содержать цифры",
                      buttonTitle: "Хорошо",
                      handler: nil)
            return nil
        }
        
        return (login: login, password: password)
    }
    
    private func signUp() {
        
        let loginPassword =  verifyLoginPasswordFields()
       
        guard let login = loginPassword?.login else { return }
        guard let password = loginPassword?.password else { return }

        loginTextField.text = nil
        passwordTextField.text = nil
        
        user = User(login: login, password: password)
        StorageManager.storageManager.saveUser(user)
        
        performSegue(withIdentifier: "ShowCategories", sender: self)
        
    }
    
    private func signIn() {
       
        if let expectedUser = StorageManager.storageManager.getUser() {
            
            let loginPassword =  verifyLoginPasswordFields()
            
            guard let login = loginPassword?.login else { return }
            guard let password = loginPassword?.password else { return }
            
            if login == expectedUser.login, password == expectedUser.password {
                performSegue(withIdentifier: "ShowCategories", sender: self)
            }
            else {
                showAlert(withTitle: "Ошибка",
                          message: "Неправильный логин или пароль",
                          buttonTitle: "Хорошо",
                          handler: nil)
            }
        } else {
            showAlert(withTitle: "Вы еще не зарегистрированы в приложении",
                      message: "Сперва выполните регистрацию",
                      buttonTitle: "Хорошо") { action in
                        self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //    @IBAction func backButtonPressed() {
//        dismiss(animated: true, completion: nil)
//    }
    
    
    @IBAction func signInUpButtonPressed() {
        if isSignInClicked {
            signIn()
        } else {
            signUp()
        }
        
        loginTextField.text = ""
        passwordTextField.text = ""
    }
}

extension SignInUpViewController {
    private func showAlert(withTitle title: String, message: String, buttonTitle: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIHelpers.showAlert(withTitle: title,
                                        message: message,
                                        buttonTitle: buttonTitle,
                                        handler: handler)
        present(alert, animated: true, completion: nil)
    }
}

extension SignInUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
