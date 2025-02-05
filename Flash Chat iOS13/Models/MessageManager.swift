//
//  MessageManager.swift
//  Flash Chat iOS13
//
//  Created by Tehillah Kangamba on 2025-02-04.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation

import FirebaseFirestore




struct MessageManager{
    
    private let db = Firestore.firestore()
    
   
     
    private var messages: [Message] = [
        Message(sender: "tehillahkangamba@gmail.com", body: "test 1"),
        Message(sender: "tehillahkangamba@gmail.com", body: "Yala pass the hummus"),
        Message(sender: "tehillahkangamba@gmail.com", body: "Gojo sama")
    ]
    
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
    
}
