//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import IQKeyboardManagerSwift

class ChatViewController: KUIViewController {
 

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messageManager = MessageManager()
    
    var authManager = AuthManager()
    
    var messages: [Message] = []
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    setupDismissKeyboardGesture()
        
        
        self.tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        
       // self.messageTextfield.delegate = self
        
        
        self.messageManager.delegate = self
        
        self.messageManager.loadMessages()
        
        self.messageManager.listenForMessages()
        
        
        
     //   self.messages = self.messageManager.getMessages()
        
        
     
        navigationItem.hidesBackButton = true
        
        title = K.appName
        
        self.authManager.delegate = self
        
        self.tableView.isScrollEnabled = true
        
        
       // self.messages = self.messageManager.getMessages()
        
        IQKeyboardManager.shared.isEnabled = false
      
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared.isEnabled = true
        
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


