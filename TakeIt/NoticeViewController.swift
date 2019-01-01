//
//  NoticeViewController.swift
//  TakeIt
//
//  Created by 무릉 on 31/12/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class NoticeViewController : BaseViewController {
    
    let itemLabel : [String] = ["가자가자! 8.1.7 업데이트!","타임지 선정 2018년 100대 기업! Take It!","독수리 5형제보다 더 유명한 의정부 5형제","iOS 10.3.5 이하 버전 지원 종료"]
    
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

extension NoticeViewController :  UITableViewDelegate {
    
}

extension NoticeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemLabel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NoticeItemCell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath) as! NoticeItemCell
        cell.noticeLabel.text = itemLabel[indexPath.item]
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
}
