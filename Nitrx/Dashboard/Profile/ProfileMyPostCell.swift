//
//  ProfileMyPostCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 22/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class ProfileMyPostCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var colView: UICollectionView!
    
    var posts = [PostsClass]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        colView.delegate = self
        colView.dataSource = self

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 3 - 2, height: collectionView.frame.size.width / 3 - 2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileChildPostCell", for: indexPath) as! MyProfileChildPostCell
    
        if let img = posts[indexPath.row].image {
            cell.image.imageLoadingUsingUrlString(urlString: img)
        }

        cell.label.text = posts[indexPath.row].postText
     
        
        return cell
        
    }
    
    
    
}
