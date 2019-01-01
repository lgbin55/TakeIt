//
//  CardViewController.swift
//  TakeIt
//
//  Created by 무릉 on 20/11/2018.
//  Copyright © 2018 lgbin. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import AACarousel

class BoardDetailCardViewController: BaseViewController,AACarouselDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var carouselView: AACarousel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainContainer: UIView!
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    private var interactionController: UIPercentDrivenInteractiveTransition?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    func commonInit() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundViews()
        setSlideShow()
        setScrollView()
        
    }
    
    func setScrollView(){
        scrollView.delegate = self
        scrollView.clipsToBounds = true
//        scrollView.bounces = false
    }
   
    
    func setSlideShow(){
        
        let pathArray = ["http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                         "https://ak.picdn.net/assets/cms/97e1dd3f8a3ecb81356fe754a1a113f31b6dbfd4-stock-photo-photo-of-a-common-kingfisher-alcedo-atthis-adult-male-perched-on-a-lichen-covered-branch-107647640.jpg",
                         "http://www.conversion-uplift.co.uk/wp-content/uploads/2016/09/Lamborghini-Huracan-Image-672x372.jpg",
                         "http://www.conversion-uplift.co.uk/wp-content/uploads/2016/09/Lamborghini-Huracan-Image-672x372.jpg",
                         "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg"]
        carouselView.delegate = self
        carouselView.contentMode = .scaleToFill
        carouselView.setCarouselData(paths: pathArray,  describedTitle: [], isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
        
        //optional method
        carouselView.setCarouselOpaque(layer: false, describedTitle: true, pageIndicator: false)
        carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: UIColor.clear)
    }
    
    //require method
    func downloadImages(_ url: String, _ index:Int) {
        
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            
            self.carouselView.images[index] = downloadImage!
        })
        
    }
    
    //optional method (interaction for touch image)
    func didSelectCarouselView(_ view:AACarousel ,_ index:Int) {
        
        print("index : \(index)")
        
//        let alert = UIAlertView.init(title:"Alert" , message: titleArray[index], delegate: self, cancelButtonTitle: "OK")
//        alert.show()
        
        //startAutoScroll()
        //stopAutoScroll()
    }
    
    //optional method (show first image faster during downloading of all images)
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    
    func startAutoScroll() {
        //optional method
        carouselView.startScrollImageView()
        
    }
    
    func stopAutoScroll() {
        //optional method
        carouselView.stopScrollImageView()
    }
 
    func moveViewScroll(){
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
        }
        
        if (scrollView.contentOffset.y <= 0){
            //reach top
//            let panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(handleDismissPanGesture(gestureRecognizer:)))
//            self.scrollView.addGestureRecognizer(panGestureRecognizer2)
//            print("contentOffset.y : \(scrollView.contentOffset.y)")
//            print("scroll heigt : \(scrollView.frame.height)")
            percentage = Double(((scrollView.contentOffset.y * -1) * 1.5) / scrollView.frame.height)
            
            var mainContainerFrame = mainContainer.frame
            mainContainerFrame.origin.y = scrollView.contentOffset.y
            mainContainer.frame = mainContainerFrame

            interactionController?.update(CGFloat(percentage))
            
        }
        
        if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            //not top and not bottom
            
        }
    }
    var percentage = 0.0
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDragging")
        scrollView.bounces = true
        interactionController = UIPercentDrivenInteractiveTransition()
        dismiss(animated: true, completion: nil)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("scrollViewDidEndDragging")
        if percentage < 0.4 {
            interactionController?.cancel()
        } else {
            interactionController?.finish()
        }
        interactionController = nil
    }
   
   
//    @objc private func handleDismissPanGesture(gestureRecognizer: UIPanGestureRecognizer) {
//
//        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
//        let height = (gestureRecognizer.view?.bounds.height)!
//        let percentage = (translation.y / height)
//        print("percentage: \(percentage)")
//
//        switch gestureRecognizer.state {
//        case .began:
//            interactionController = UIPercentDrivenInteractiveTransition()
//            dismiss(animated: true, completion: nil)
//        case .changed:
//            interactionController?.update(percentage)
//        case .ended:
//            if percentage < 0.5 {
//                interactionController?.cancel()
//            } else {
//                interactionController?.finish()
//
//            }
//            interactionController = nil
//        default: break
//        }
//    }
    
    func roundViews() {
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
    }
    
    @IBAction func viewDismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension BoardDetailCardViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Get UIKit to animate if it's not an interative animation
        return interactionController != nil ? AnimationController(direction: .present) : nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Get UIKit to animate if it's not an interative animation
        return interactionController != nil ? AnimationController(direction: .dismiss) : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}


