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

class SignInVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBOutlet weak var emailFeild: FancyFeild!
    @IBOutlet weak var passwordFeild: FancyFeild!
    
    
    @IBAction func fbBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to anuthenticate - \(error)")
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
                print("Unable to authenticate with firebase - \(error)")
            } else {
                print("Sucessfull authenicated with firebase")
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
                        } else {
                            print("Sucessfully authenicated with firebase")
                        }
                    })
                }
            })
        }
        
    }
    
}

