//
//  MessageManager.swift
//  Flash Chat iOS13
//
//  Created by Tehillah Kangamba on 2025-02-04.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation

import FirebaseFirestore


protocol MessageDelegate{
    
    func didUpdateMessage(messages: [Message])
}

struct MessageManager {
    
    private let db = Firestore.firestore()
    
    var delegate: MessageDelegate?
    
   
     
    private var messages: [Message] = []
    
    
    func getMessages() -> [Message]{
        
        
        return self.messages
    }
    
    func getMessageCount() -> Int{
        return self.messages.count
    }
    
    func sendMessage(sender: String, body: String){
        self.db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: sender,
            K.FStore.bodyField: body
        ], completion:{ (error) in
            if let e = error {
                print(e)
            }else{
                print("saved data")
            }
        })
    }
    
    func loadMessages(){
       
        var  newMessages: [Message] = []
        self.db.collection(K.FStore.collectionName).getDocuments(completion: {
            (querySnapshot, error) in
            
            if let e = error {
                print("couldnt get data error:\(e)")
                return;
            }else{
                
                if let messageDocuments = querySnapshot?.documents{
                    
                    
                    for messageDocument in messageDocuments{
                        
                        let messageData = messageDocument.data()
                        
                        if let senderEmail = messageData[K.FStore.senderField] as? String, let messageBody = messageData[K.FStore.bodyField] as? String {
                           // print("\(senderEmail)  \(messageBody)")
                            newMessages.append(Message(sender: senderEmail, body: messageBody))
                            //self.updateMessageList(messages: messages)
                            
                            //print(newMessages.count)
                            
                            
                            
                        }
                    }
                }
                self.delegate?.didUpdateMessage(messages: newMessages)
            }
            
        })
       
       
     //   print(self.messages[0].body)
    }
    
}
