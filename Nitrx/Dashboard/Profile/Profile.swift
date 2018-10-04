//
//  Profile.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 17/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Profile: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var homeCol: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        homeCol.delegate = self
        homeCol.dataSource = self

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
        
        return 3
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 800)

        } else if indexPath.row == 1 {
            return CGSize(width: collectionView.frame.size.width, height: 40)
            
        } else if indexPath.row == 2 {
            return CGSize(width: collectionView.frame.size.width, height: 400)
            
        } else {
            return UICollectionViewFlowLayout.automaticSize
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        if indexPath.row == 0 {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileColCell", for: indexPath) as! ProfileColCell
           
            return cell
            
        } else if indexPath.row == 1 {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileMyPostHeaderCell", for: indexPath) as! ProfileMyPostHeaderCell
            
            return cell

        } else if indexPath.row == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileMyPostCell", for: indexPath) as! ProfileMyPostCell
            
            return cell

        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColCell", for: indexPath) as! HomeColCell
            
            return cell
            
        }
        
    }

}
