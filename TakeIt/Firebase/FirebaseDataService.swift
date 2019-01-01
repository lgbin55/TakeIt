//
//  FirebaseDataService.swift
//  TakeIt
//
//  Created by 무릉 on 07/12/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

//최상의 참조(root)
fileprivate let baseRef = Database.database().reference()

class FirebaseDataService {
    static let sharedInstance = FirebaseDataService()
    
    //사용자에 대한 래퍼런스
    let userRef = baseRef.child("user")
    
    //채탕방에 대한 래퍼런스
    let groupRef = baseRef.child("group")
    
    //채팅 말풍선 하나에 대한 래퍼런스
    let messageRef = baseRef.child("message")
    
    //현재 접속중인 유저의 uid
    var currentUserUid : String? {
        get{
            guard let uid = Auth.auth().currentUser?.uid else{
                return nil
            }
            return uid
        }
    }
    
    //신규 유저 만들기
    func createUserInfoFromAuth(uid: String, userData : Dictionary<String,String>) {
        userRef.child(uid).updateChildValues(userData)
    }
    
    
}
