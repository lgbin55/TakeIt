//
//  SplashViewController.swift
//  TakeIt
//
//  Created by 무릉 on 19/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class SplashViewController: UIViewController {
    @IBOutlet weak var logoStackView: UIStackView!
    @IBOutlet weak var takeStackView: UIStackView!
    @IBOutlet weak var itStackeView: UIStackView!
    @IBOutlet weak var bottomText: UILabel!
    @IBOutlet weak var icon_airplan: UIImageView!
    
    
    @IBOutlet weak var airplanConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainLogoCenterXConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setGoogleSign()
    }
    
    func setGoogleSign(){
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 4, animations: {
            self.airplanConstraint.constant = 24
        }) { (action) in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.loginCheck()
            })
        }
        
        UIView.animate(withDuration: 2) {
            self.logoStackView.spacing = 20.0
            self.takeStackView.spacing = 0.0
            self.itStackeView.spacing = 0.0
        }
    }
    
    func loginCheck(){
        let userData = UserInfo.sharedInstance
        if let _ = userData.user_id {
            GIDSignIn.sharedInstance().signIn()
        }else {
             let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

extension SplashViewController : GIDSignInUIDelegate,GIDSignInDelegate {
    
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
            
            print("userID : \(user.userID ?? "")")
            print("userName : \(user.profile.name ?? "")")
            print("userEmail : \(user.profile.email ?? "")")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "MainNavigationVC") as? UINavigationController {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
}
