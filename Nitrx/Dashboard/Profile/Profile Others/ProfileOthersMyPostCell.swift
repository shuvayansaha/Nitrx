//
//  ProfileOthersMyPostCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 09/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class ProfileOthersMyPostCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var colView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colView.delegate = self
        colView.dataSource = self
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 3 - 2, height: collectionView.frame.size.width / 3 - 2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileOthersMyPostCellChild", for: indexPath) as! ProfileOthersMyPostCellChild
        
        return cell
        
    }
    
}
