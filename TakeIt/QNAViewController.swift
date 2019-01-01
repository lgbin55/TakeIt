//
//  QNAViewController.swift
//  TakeIt
//
//  Created by 무릉 on 31/12/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class QNAViewController : BaseViewController {
    
    
     /// 탭 테크 설정, 문의하기 0 , 문의내역확인 1
     var tag = 0
    @IBOutlet weak var qnaLabel: UILabel!
    @IBOutlet weak var qnaListLabel: UILabel!
    @IBOutlet weak var qnaUnderLine: UIView!
    @IBOutlet weak var qnaListUnderLine: UIView!
    @IBOutlet weak var qnaMainView: UIView!
    @IBOutlet weak var qnaListMainView: UIView!
    
    
     let itemLabel : [String] = ["글쓰기가 안되요 문의합니다","채팅이 안되요 안돼!!","문의문의","ㅋㅋㅋㅋㅋㅋㅋ","asdasdasd"]
    
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
    
    @IBAction func setTabAction(_ sender: UIButton) {
        setView(tag: sender.tag)
    }
    
    func setView(tag : Int) {
        if tag == 0 {
            qnaMainView.isHidden = false
            qnaListMainView.isHidden = true
            qnaLabel.textColor = UIColor.black
            qnaListLabel.textColor = UIColor.lightGray
            qnaUnderLine.isHidden = false
            qnaListUnderLine.isHidden = true
        }else if tag == 1 {
            qnaMainView.isHidden = true
            qnaListMainView.isHidden = false
            qnaLabel.textColor = UIColor.lightGray
            qnaListLabel.textColor = UIColor.black
            qnaUnderLine.isHidden = true
            qnaListUnderLine.isHidden = false
        }
    }
}

extension QNAViewController :  UITableViewDelegate {
    
}

extension QNAViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemLabel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : QNADataCell = tableView.dequeueReusableCell(withIdentifier: "QNADataCell", for: indexPath) as! QNADataCell
        cell.qnaLabel.text = itemLabel[indexPath.item]
        //        cell.message.text = groups[indexPath.row].messages.vÚ
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
}


