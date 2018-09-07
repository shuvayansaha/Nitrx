//
//  PageController.swift
//  Nitrx
//
//  Created by Rplanx on 07/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class PageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "Welcome"),
                self.newVc(viewController: "SignUp")]
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self .dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        configurePageControl()
    }
    
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.green
        
        self.view.addSubview(pageControl)


    }
    
    
    
    
    func newVc(viewController: String) -> UIViewController {
        
        return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex =  orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex  = viewControllerIndex - 1
        
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
        
        let nextIndex  = viewControllerIndex + 1
        
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
