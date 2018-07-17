//
//  FeedViewController.swift
//  Social-App
//
//  Created by Asher Ahsan on 17/07/2018.
//  Copyright © 2018 swift. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import FirebaseAuth

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        print("ID removed from the keychain")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    

}
