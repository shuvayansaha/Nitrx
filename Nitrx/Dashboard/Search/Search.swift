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
    @IBOutlet weak var cellCol: UICollectionView!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var saerchBar: UISearchBar!
    
    let category = ["Trending", "People", "Food", "Tech", "Film", "Other"]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        cellCol.delegate = self
        cellCol.dataSource = self
        
        colView.delegate = self
        colView.dataSource = self
        
        let textFieldInsideSearchBar = saerchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let red = UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1).cgColor
        let green = UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1).cgColor

        let gradient = CAGradientLayer()
        
        gradient.frame = navView.bounds
        gradient.colors = [red, green]
        
        navView.layer.insertSublayer(gradient, at: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if collectionView == colView {
            return category.count
        } else {
            return 50
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == colView {
            return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height)
      
            
            if indexPath.row == 0 {
                return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width - collectionView.frame.size.width/3)
            
                
            } else {
                
                return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width - collectionView.frame.size.width/3)
        
                
            }
            
           
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == colView {
            
            if indexPath.row == 0 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategoryCell", for: indexPath) as! SearchCategoryCell
                cell.label.text = category[indexPath.row]
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CallSearch2", for: indexPath) as! CallSearch2
                return cell
            }
           
            
            
           
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CallSearch2", for: indexPath) as! CallSearch2
            return cell
        }
    }
    
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
