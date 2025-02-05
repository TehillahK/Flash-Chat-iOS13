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
    
    func didSignOut(signedOut: Bool)
    
}

extension AuthProtocol{
    
    func getAuthResult(authResult: AuthDataResult){
        print("default behaviour")
    }
    
    func didSignOut(signedOut: Bool){
            print("user attempting signout")
    }
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
        Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, error in
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
        })
    }
    
    
    func signOutUser(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            delegate?.didSignOut(signedOut: true)
        } catch let signOutError {
            delegate?.didSignOut(signedOut: false)
            delegate?.onAuthError(error: signOutError)
          //print("Error signing out: %@", signOutError)
        }
    }
    
    func getUserEmail()-> String?{
        return Auth.auth().currentUser?.email
    }
    
    
   
}
