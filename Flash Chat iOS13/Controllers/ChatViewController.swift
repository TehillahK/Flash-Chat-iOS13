//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
 

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messageManager = MessageManager()
    
    var authManager = AuthManager()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        title = K.appName
        
        self.authManager.delegate = self
        
        self.tableView.dataSource = self
        
        self.messages = self.messageManager.getMessages()
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

    
    
}


extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageManager.getMessageCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.messageText.text = messages[indexPath.row].body
        
        return cell
    }
    
    
}

extension ChatViewController: AuthProtocol {
    @IBAction func logoutBtnPressed(_ sender: UIBarButtonItem) {
        authManager.signOutUser()

    }
    

    
    func didSignOut(signedOut: Bool) {
        if signedOut{
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
   
    func onAuthError(error: any Error) {
        print(error.localizedDescription)
    }
    
    
}
