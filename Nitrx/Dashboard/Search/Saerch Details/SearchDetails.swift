//
//  SearchDetails.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 10/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class SearchDetails: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var homeCol: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCol.delegate = self
        homeCol.dataSource = self
        
        // custom search bar on navigation bar
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 120, height: 20))
        searchBar.placeholder = "Search..."
        
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        //        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        // custom navigation bar right side icon
        let notificationBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        notificationBtn.setImage(UIImage(named: "notification"), for: [])
        notificationBtn.addTarget(self, action: #selector(notification), for: UIControl.Event.touchUpInside)
        notificationBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let notificationButton = UIBarButtonItem(customView: notificationBtn)
        
        // custom navigation bar right side icon
        let plusBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        plusBtn.setImage(UIImage(named: "plus"), for: [])
        plusBtn.addTarget(self, action: #selector(notification), for: UIControl.Event.touchUpInside)
        plusBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let plusButton = UIBarButtonItem(customView: plusBtn)
        
        
        
        self.navigationItem.rightBarButtonItems = [notificationButton, leftNavBarButton, plusButton]
//        self.navigationItem.leftBarButtonItems = [plusButton, leftNavBarButton, notificationButton]
    }
    
    @objc func notification() {
        print("wallet")
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let backItem = UIBarButtonItem()
//        backItem.title = "Back"
//        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
//    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // navigation bar gradient color
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 1000)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchDetailsCell", for: indexPath) as! SearchDetailsCell
        
        return cell
    }
    


}
