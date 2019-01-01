//
//  MainTableViewController.swift
//  TakeIt
//
//  Created by 무릉 on 19/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class BoardSearchViewController : BaseViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTextContainer: UIView!
    
    var keyboardHeight = 0.0
    var history : [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardDoneInsert()
        setTableView()
        initView()
        setNotificationCenter()
        
    }
    
    var toolbar:UIToolbar?
    func keyboardDoneInsert(){
        //가상 키보드 취소하기 버튼 추가
        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar?.setItems([flexSpace, doneBtn], animated: false)
        toolbar?.sizeToFit()
    }
    
    @objc func doneButtonAction() {
        self.view.viewWithTag(100)?.removeFromSuperview()
        backgroundContainerView.isHidden = true
        historyTableView.isHidden = true
        view.endEditing(true)
    }
    
    
    func setNotificationCenter(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = Double(keyboardRectangle.height)
            setSearchView()
        }
    }
    
    //검색 뷰
    func setSearchView(){
        
        let backgroundView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            return view
        }()
        backgroundView.tag = 100
        backgroundContainerView.isHidden = false
        backgroundContainerView.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: searchTextContainer.bottomAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        history = [
            ["seachTitle" : "검색어1" , "date" : "11.28"],
            ["seachTitle" : "검색어2" , "date" : "11.29"],
            ["seachTitle" : "검색어3" , "date" : "11.30"],
            ["seachTitle" : "검색어3" , "date" : "11.30"],
            ["seachTitle" : "검색어3" , "date" : "11.30"]
        ]
        

        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        historyTableView.isHidden = false
        historyTableView.topAnchor.constraint(equalTo: searchTextContainer.bottomAnchor, constant: 0).isActive = true
        historyTableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0).isActive = true
        historyTableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 0).isActive = true
        let height = (Double(self.view.frame.height) - (Double(searchTextContainer.frame.height) + keyboardHeight))
        let itemHeight : Double = Double(history.count) * 50.0
        print("height : \(height)")
        print("itemHeight : \(itemHeight)")

        if height > itemHeight {
            historyTableView.heightAnchor.constraint(equalToConstant: CGFloat(itemHeight)).isActive = true
        }else {
            historyTableView.heightAnchor.constraint(equalToConstant: CGFloat(height - 60)).isActive = true
        }
       
        
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tag = 1
        tableView.backgroundColor = UIColor.clear
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.tag = 2
//        historyTableView.backgroundColor = UIColor.clear
    }
    
    func initView(){
        searchTextField.inputAccessoryView = toolbar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.containerView.backgroundColor = UIColor.white
    }
    
    
    //배경 클릭시 가상 키보드 종료
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.viewWithTag(100)?.removeFromSuperview()
        backgroundContainerView.isHidden = true
        historyTableView.isHidden = true
        view.endEditing(true)
    }
    
}

extension BoardSearchViewController : UITableViewDelegate {
    
}
extension BoardSearchViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView.tag == 1 {
            return 20
        }else if tableView.tag == 2 {
            return history.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.tag)
        if tableView.tag == 1 {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "CardViewVC") as? BoardDetailCardViewController {
                present(vc, animated: true, completion: nil)
                
            }
        }else if tableView.tag == 2 {
            print("검색!")
            searchTextField.text = "\(history[indexPath.item]["seachTitle"]!)"
            self.view.viewWithTag(100)?.removeFromSuperview()
            backgroundContainerView.isHidden = true
            historyTableView.isHidden = true
            view.endEditing(true)
            tableView.reloadData()
        }
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 2{
            let historyCell : HistoryItemCell = tableView.dequeueReusableCell(withIdentifier: "HistoryItemCell", for: indexPath) as! HistoryItemCell
            historyCell.backgroundColor = UIColor.clear
            historyCell.selectionStyle = .none
            historyCell.historyText.text = "\(history[indexPath.row]["seachTitle"]!)"
            historyCell.date.text = "\(history[indexPath.row]["date"]!)"
            return historyCell
        }else {
            let cell : BoardDataSearchCell = tableView.dequeueReusableCell(withIdentifier: "BoardDataSearchCell", for: indexPath) as! BoardDataSearchCell
            
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.tag == 1 {
            return 100
        }else if tableView.tag == 2 {
            return 50
        }else{
            return 0
        }
        
    }

    
    
}
