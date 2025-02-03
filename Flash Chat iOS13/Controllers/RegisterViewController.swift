//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, AuthProtocol {
   

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var authManager = AuthManager()
    
    override func viewDidLoad() {
        self.authManager.delegate = self
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let userEmail = emailTextfield.text, let userPassword = passwordTextfield.text{
            print("\(userEmail) \(userPassword)")
            authManager.registerUser(email: userEmail, password: userPassword)
        }
    }
    
    
    
    func getAuthResult(authResult: AuthDataResult) {
        
        print("just signed up \(authResult.user.email!)")
        
        self.performSegue(withIdentifier: "registerToChat", sender: self)
    }
    
    
    
    
    
    func onAuthError(error: any Error) {
        print(error.localizedDescription)
        
    }
    
    
}
