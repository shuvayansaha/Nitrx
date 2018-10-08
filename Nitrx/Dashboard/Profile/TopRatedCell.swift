//
//  TopRatedCell.swift
//  Nitrx
//
//  Created by Rplanx on 08/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class TopRatedCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var colView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        colView.delegate = self
        colView.dataSource = self
        
    }
    
    
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height)

        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCellChild", for: indexPath) as! TopRatedCellChild
        
        return cell
        
        

    }
}
