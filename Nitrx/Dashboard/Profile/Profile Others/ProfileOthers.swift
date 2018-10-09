//
//  ProfileOthers.swift
//  Nitrx
//
//  Created by Rplanx on 09/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class ProfileOthers: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var homeCol: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCol.delegate = self
        homeCol.dataSource = self
        
 
        
        let pencilBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        pencilBtn.setImage(UIImage(named: "notification"), for: [])
        pencilBtn.addTarget(self, action: #selector(searchBtnPressed), for: UIControl.Event.touchUpInside)
        pencilBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let pencilButton = UIBarButtonItem(customView: pencilBtn)
        
        self.navigationItem.rightBarButtonItems = [pencilButton]
        
        //        // navigation bar logo centre
        //        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        //        imageView.contentMode = .scaleAspectFit
        //        let image = UIImage(named: "logo")
        //        imageView.image = image
        //        navigationItem.titleView = imageView
    }
    
    @objc func wallet() {
        print("wallet")
        
    }
    
    @objc func notification() {
        print("wallet")
        
    }
    
    @objc func searchBtnPressed() {
        print("wallet")
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 800)
            
        } else if indexPath.row == 1 {
            return CGSize(width: collectionView.frame.size.width, height: 40)
            
        } else if indexPath.row == 2 {
            // top rated  cell
            return CGSize(width: collectionView.frame.size.width, height: 150)
            
        } else if indexPath.row == 3 {
            return CGSize(width: collectionView.frame.size.width, height: 60)
            
        } else if indexPath.row == 4 {
            return CGSize(width: collectionView.frame.size.width, height: 400)
            
        } else {
            return UICollectionViewFlowLayout.automaticSize
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileOthersCell", for: indexPath) as! ProfileOthersCell
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileOthersTopRatedHeader", for: indexPath)
            
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileOthersTopRatedCell", for: indexPath) as! ProfileOthersTopRatedCell
            
            return cell
            
        } else if indexPath.row == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileOthersTopRatedHeader2", for: indexPath)
            
            return cell
            
        } else if indexPath.row == 4 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileOthersMyPostCell", for: indexPath) as! ProfileOthersMyPostCell
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileOthersMyPostCell", for: indexPath) as! ProfileOthersMyPostCell
            
            return cell
            
        }
        
    }

}
