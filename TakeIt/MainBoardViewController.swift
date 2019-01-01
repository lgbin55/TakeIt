//
//  SubTableViewController.swift
//  TakeIt
//
//  Created by 무릉 on 19/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit

class MainBoardViewController : BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
    }
}

extension MainBoardViewController : UICollectionViewDelegate {
    
}
extension MainBoardViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : BoardDataCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardDataCollectionCell", for: indexPath) as! BoardDataCollectionCell
        cell.backgroundColor = UIColor.clear
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "CardViewVC") as? BoardDetailCardViewController {
            
            present(vc, animated: true, completion: nil)
            
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BoardMainBanner", for: indexPath) as! BoardMainBannerCell
        return bannerView
        
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BoardMainBannerCell", for: indexPath) as! BoardMainBannerCell
//            return bannerView
//
//        default:
//            print("MainBoardViewController --> bannerView Error")
//        }
    }
        
    
}
extension MainBoardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 10
        let collectionCellSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionCellSize/2, height: collectionCellSize/1.5)
        
    }
    
}
