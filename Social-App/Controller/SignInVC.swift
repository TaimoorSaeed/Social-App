//
//  ViewController.swift
//  Social-App
//
//  Created by Asher Ahsan on 11/07/2018.
//  Copyright © 2018 swift. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    
    @IBOutlet weak var emailFeild: FancyFeild!
    @IBOutlet weak var passwordFeild: FancyFeild!
    
    
    @IBAction func fbBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to anuthenticate - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("User cancel facebook auth")
            } else {
                print("Sucessfullt authenticated with facebook")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(_credential: credential)
            }
        }
    }
    
    func firebaseAuth(_credential : AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: _credential) { (user, error) in
            if error != nil {
                print("Unable to authenticate with firebase - \(String(describing: error))")
            } else {
                print("Sucessfull authenicated with firebase")
                if let user = user{
                    print(user.user.uid)
                    self.completeSignIn(id: user.user.uid)
                }
            }
        }
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailFeild.text , let pwd = passwordFeild.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Email user authenticaed with firebase")
                } else {
                    print(error?.localizedDescription)
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Unable to authenticate with firebase using email")
                            print(error?.localizedDescription)
                        } else {
                            print("Sucessfully authenicated with firebase")
                            if let user = user {
                                self.completeSignIn(id: user.user.uid)
                            }
                            
                        }
                    })
                }
            })
        }
        
    }
    
    func completeSignIn(id: String) {
        let keychaingResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data saved to keychain \(keychaingResult)")
         performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
}

