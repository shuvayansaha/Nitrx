//
//  SearchCategory.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 01/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class SearchCategory: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var subCol: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        subCol.delegate = self
        subCol.dataSource = self
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: collectionView.frame.size.width/3 - 8, height: 138)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategorySubCell", for: indexPath) as! SearchCategorySubCell
        
        return cell
        
        
    }
}
