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
        self.messageManager.delegate = self
        
        self.messageManager.loadMessages()
        
        self.messageManager.listenForMessages()
        
     //   self.messages = self.messageManager.getMessages()
        
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        navigationItem.hidesBackButton = true
        
        title = K.appName
        
        self.authManager.delegate = self
        
        self.tableView.dataSource = self
        
        
        
       // self.messages = self.messageManager.getMessages()
      
      
        
        

    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        let userEmail = self.authManager.getUserEmail()
        
        if let messageText = messageTextfield.text, let senderEmail = userEmail {
            
            self.messageManager.sendMessage(sender: senderEmail, body: messageText)
            
        }
    }
    

    
    
}

extension ChatViewController: MessageDelegate {
    
    func didUpdateMessage(messages: [Message]) {
        self.messages = messages
        print(messages.count)
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
        
    }
    
    
}



extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.messageText.text = self.messages[indexPath.row].body
        
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


