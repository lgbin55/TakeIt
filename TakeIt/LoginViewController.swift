//
//  LoginViewController.swift
//  TakeIt
//
//  Created by 무릉 on 06/12/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class LoginViewController : BaseViewController {
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGoogleSign()
        
    }
    
    func setGoogleSign(){
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
//        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func googleLoginAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
}

extension LoginViewController : GIDSignInUIDelegate,GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)

        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            
            let userData = UserInfo.sharedInstance
            userData.user_id = user.userID!
            userData.user_name = user.profile.name ?? ""
            userData.user_email = user.profile.email ?? ""
            
            let userDic = [
                "id" : user.userID!,
                "name" : user.profile.name ?? "",
                "email" : user.profile.email ?? ""
            ]
            
            FirebaseDataService.sharedInstance.createUserInfoFromAuth(uid: (Auth.auth().currentUser?.uid)!, userData: userDic)
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "MainNavigationVC") as? UINavigationController {
                self.present(vc, animated: true, completion: nil)
            }
            // User is signed in
        }
    }
    
}
