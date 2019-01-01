//
//  ChatGroupViewController.swift
//  firebaseTest
//
//  Created by hPark_ipl on 2017. 4. 28..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class ChatGroupViewController: BaseViewController {
    
    var groups: [Group] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.tableFooterView = UIView()  //빈공간 밑줄 제거
        //밑줄 좌우 공백 적용
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.separatorInset.left = 15
        self.tableView.separatorInset.right = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchChatGroupList()
    }
    
    func fetchChatGroupList() {
        if let uid = FirebaseDataService.sharedInstance.currentUserUid {
            FirebaseDataService.sharedInstance.userRef.child(uid).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String, Int> {
                    self.groups.removeAll()
                    for (key, _) in dict {
                        FirebaseDataService.sharedInstance.groupRef.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                            if let data = snapshot.value as? Dictionary<String, AnyObject> {
                                let group = Group(key: key, data: data)
                                self.groups.append(group)
                                
                                DispatchQueue.main.async(execute: { 
                                    self.tableView.reloadData()
                                })
                            }
                        })
                    }
                }
            })
        }
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "userList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userList" {
            let userListVC = segue.destination as! UserListViewController
            let chatGroupVC = sender as! ChatGroupViewController
            userListVC.chatGroupVC = chatGroupVC
        } else if segue.identifier == "chatting" {
            let chatVC = segue.destination as! ChatViewController
            chatVC.groupKey = sender as? String
        }
    }
}

extension ChatGroupViewController : UITableViewDelegate {
    
}
extension ChatGroupViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chatting", sender: groups[indexPath.row].key)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatGroupDataCell = tableView.dequeueReusableCell(withIdentifier: "ChatGroupCell", for: indexPath) as! ChatGroupDataCell
        cell.name.text = groups[indexPath.row].name
        //        cell.message.text = groups[indexPath.row].messages.vÚ
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    
}
