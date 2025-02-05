//
//  MessageManager.swift
//  Flash Chat iOS13
//
//  Created by Tehillah Kangamba on 2025-02-04.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation

struct MessageManager{
     
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
    
}
