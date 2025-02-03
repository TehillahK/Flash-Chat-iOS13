//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController, AuthProtocol {
 

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextfield: UITextField!
    
    var authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        title = K.appName
        
        self.authManager.delegate = self

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIBarButtonItem) {
        authManager.signOutUser()

    }
    

    
    func didSignOut(signedOut: Bool) {
        if signedOut{
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    func getAuthResult(authResult: FirebaseAuth.AuthDataResult) {
        
    }
    
    func onAuthError(error: any Error) {
        print(error.localizedDescription)
    }
    
    
    
}
