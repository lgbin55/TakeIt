//
//  SettingViewController.swift
//  TakeIt
//
//  Created by 무릉 on 29/12/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController : BaseViewController {
    
    let itemLabel : [String] = ["계정관리","채팅관리","화면관리","고객센터","도움말"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        //밑줄 좌우 공백 적용
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.separatorInset.left = 15
        self.tableView.separatorInset.right = 15
    }
}

extension SettingViewController :  UITableViewDelegate {
    
}

extension SettingViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemLabel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SettingItemCell = tableView.dequeueReusableCell(withIdentifier: "SettingItemCell", for: indexPath) as! SettingItemCell
        cell.settingLabel.text = itemLabel[indexPath.item]
        //        cell.message.text = groups[indexPath.row].messages.vÚ
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
}
