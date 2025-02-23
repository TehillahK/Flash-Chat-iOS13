//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, AuthProtocol {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.text = "Welcome"
        self.authManager.delegate = self
        self.errorLabel.isHidden = true
        self.emailTextfield.delegate = self
        self.passwordTextfield.delegate = self
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let userEmail = emailTextfield.text, let userPassword = passwordTextfield.text{
            authManager.signInUser(email: userEmail, password: userPassword)
        }
    }
    
    func getAuthResult(authResult: AuthDataResult) {
        print("just signed up \(authResult.user.email!)")
        
        self.performSegue(withIdentifier: K.loginSegue, sender: self)
        
    }
    
    func onAuthError(error: any Error) {
        print("Signup failed")
        print(error.localizedDescription)
        self.errorLabel.text = "Wrong password or user does not exist. Please try again."
        
        self.emailTextfield.text = nil
        
        self.passwordTextfield.text = nil
        
        self.errorLabel.isHidden = false
        
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
