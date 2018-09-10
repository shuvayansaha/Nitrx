//
//  PageController.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 08/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//
import UIKit

class PageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "Welcome"),
                self.newVc(viewController: "NickName"),
                self.newVc(viewController: "Email")]
    }()
    
    var pageControl = UIPageControl()
    var nextIndex = Int()
    var previousIndex = Int()

    
    var nxtIndex = Int()
    var prevIndex = Int()
    var nxtVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        blurTabView()
        nextButton()
        previousButton()
        configurePageControl()
        pageControl.isEnabled = false

    }
    
    
    func configurePageControl() {
        
        pageControl = UIPageControl(frame: CGRect(x: UIScreen.main.bounds.width/2 - 25, y: UIScreen.main.bounds.maxY - 50, width: 50, height: 50))
    
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.green
        
        self.view.addSubview(pageControl)

    }
    
    
    func nextButton() {
        
        let nextButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - (50 + 16), y: UIScreen.main.bounds.maxY - 50, width: 50, height: 50))

        nextButton.setTitleColor(UIColor.blue, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextFunction), for: .touchUpInside)

        self.view.addSubview(nextButton)
        
    }
    
    func previousButton() {
        
        let previousButton = UIButton(frame: CGRect(x: 16, y: UIScreen.main.bounds.maxY - 50, width: 80, height: 50))
        
        previousButton.setTitleColor(UIColor.blue, for: .normal)
        previousButton.setTitle("Previous", for: .normal)
        previousButton.addTarget(self, action: #selector(previousFunction), for: .touchUpInside)

        self.view.addSubview(previousButton)
        
    }
    
    
    @objc func nextFunction() {
        
//
//        if let firstViewController = orderedViewControllers.last {
//            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
//
//        }
        

        
//        guard let currentViewController = self.viewControllers?.first else { return }
//
//        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController ) else { return }
//
//        setViewControllers([nextViewController], direction: .forward, animated: false, completion: nil)

//        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//            guard let viewControllerIndex =  orderedViewControllers.index(of: viewController) else {
//                return nil
//            }
//
//            nextIndex = viewControllerIndex + 1
//
//            guard orderedViewControllers.count != nextIndex  else {
//                //            return orderedViewControllers.first
//                return nil
//            }
//
//            guard orderedViewControllers.count > nextIndex  else {
//                return nil
//            }
//            return orderedViewControllers[nextIndex]
//        }
//
//
//        guard let currentViewController = self.viewControllers![nextIndex] else { return }
//
//
//         let nextViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController)
//
//
        
        
//        let pageController = self.parent as! PageController
//
//        pageController.setViewControllers([self.orderedViewControllers[1]], direction: .forward, animated: true, completion: nil)
//
//        pageController.pageControl.currentPage = 1
//
        
//        setViewControllers([orderedViewControllers[1]], direction: .forward, animated: true, completion: nil)
        
//        print(orderedViewControllers[2])
//        print(nextIndex)
        
        print(nxtVC)
        
        
//        nextIndex = nxtIndex + 1
//
//        if orderedViewControllers.count != nextIndex  {
//            if orderedViewControllers.count > nextIndex {
//                setViewControllers([orderedViewControllers[nextIndex]], direction: .forward, animated: true, completion: nil)
//
//            } else {
//            }
//        } else {
//        }
        
     

    }
    
    
    @objc func previousFunction() {
        
//        if let firstViewController = orderedViewControllers.first {
//            setViewControllers([firstViewController], direction: .reverse, animated: true, completion: nil)
//        }
        
    
        print(prevIndex)

    }
    
    

    
    
    func blurTabView() {
        
        let blurTabView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width:  UIScreen.main.bounds.maxX, height: 50))
        
        blurTabView.backgroundColor = UIColor.white
        blurTabView.alpha = 0.5
        
        self.view.addSubview(blurTabView)
    }
    
    
    func newVc(viewController: String) -> UIViewController {
        
        return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
   


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        
        guard let viewControllerIndex =  orderedViewControllers.index(of: viewController) else {
            return nil
        }
        prevIndex = viewControllerIndex

        
        previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0  else {
//            return orderedViewControllers.last
            return nil
        }

        guard orderedViewControllers.count > previousIndex  else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        guard let viewControllerIndex =  orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        nxtIndex = viewControllerIndex
        nxtVC = viewController
        
        nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex  else {
//            return orderedViewControllers.first
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex  else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
        
    }
    
   
}
