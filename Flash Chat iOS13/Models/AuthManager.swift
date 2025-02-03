//
//  AuthManager.swift
//  Flash Chat iOS13
//
//  Created by Tehillah Kangamba on 2025-02-02.
//  Copyright © 2025 Angela Yu. All rights reserved.
//


import Foundation
import FirebaseAuth


protocol AuthProtocol {
    
    func getAuthResult(authResult: AuthDataResult)
    
    func onAuthError(error: Error)
    
}

struct AuthManager{
    
    var authResult: Any? = nil
    
    var delegate: AuthProtocol?
 
    
    func registerUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                delegate?.onAuthError(error: error!)
                print(error!)
                return
            }
         
            // probably safe
            if let safeAuthResult = authResult {
                print(safeAuthResult.credential?.accessToken ?? "cant get tocken")
                delegate?.getAuthResult(authResult: safeAuthResult)
                return
            }
        }
    }
    
    func signInUser(email: String, password: String){
     
    }
    
    
   
}
