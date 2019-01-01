//
//  User.swift
//  TakeIt
//
//  Created by 무릉 on 13/12/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation

class UserInfo : NSObject {
    
    var user_id : String? {
        get{
            return myDefaults.string(forKey: "USER_ID")
        }
        set{
            myDefaults.set(newValue, forKey: "USER_ID")
        }
    }
    
    var user_email : String?{
        get{
            return myDefaults.string(forKey: "USER_EMAIL")
        }
        set{
            myDefaults.set(newValue, forKey: "USER_EMAIL")
        }
    }
    var user_name : String?{
        get{
            return myDefaults.string(forKey: "USER_NAME")
        }
        set{
            myDefaults.set(newValue, forKey: "USER_NAME")
        }
    }
    
    var myDefaults : UserDefaults
    
    public static let sharedInstance = UserInfo()
    
    public override init() {
        myDefaults = UserDefaults.standard
    }
    
}
