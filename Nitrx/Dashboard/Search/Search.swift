//
//  Search.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 17/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Search: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var navView: UIView!
    
    @IBOutlet weak var colView: UICollectionView!
    
    let segmentvalue = ["Trending", "People", "Food", "Tech", "Film", "Other"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        colView.delegate = self
        colView.dataSource = self

    }

 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
//        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let gradient = CAGradientLayer()
        
        gradient.frame = view.bounds
        gradient.colors = colors
        
        navView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    
    
 
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 50)
            
        } else if indexPath.row == 1 {
            return CGSize(width: collectionView.frame.size.width, height: 118)
            
        } else if indexPath.row == 2 {
            return CGSize(width: collectionView.frame.size.width, height: 130)
            
        } else if indexPath.row == 3 {
            return CGSize(width: collectionView.frame.size.width, height: 65)
            
        } else if indexPath.row == 4 {
            return CGSize(width: collectionView.frame.size.width, height: 500)
            
        } else {
            return UICollectionViewFlowLayout.automaticSize
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategory", for: indexPath) as! SearchCategory
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "label1", for: indexPath)
            
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRated", for: indexPath) as! TopRated
            
            return cell
            
        } else if indexPath.row == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "label2", for: indexPath)
            
            return cell
            
        } else if indexPath.row == 4 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
            
            return cell
            
        }
        
    }
    
    
}
