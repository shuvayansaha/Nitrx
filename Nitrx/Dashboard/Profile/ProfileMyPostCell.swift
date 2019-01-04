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
        
        return CGSize(width: collectionView.frame.size.width / 3 - 2, height: collectionView.frame.size.width / 3 + 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileChildPostCell", for: indexPath) as! MyProfileChildPostCell
    
        if let img = posts[indexPath.row].image {
            cell.image.imageLoadingUsingUrlString(urlString: img)
        }

        cell.label.text = posts[indexPath.row].postText
//        cell.image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImage)))
        
//                cell.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImage)))

        return cell
        
    }
    
    @objc func tapImage() {
        
        print("tap image")
        
        
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == colView {
//
//            let postCatId = posts[indexPath.row].post_cat_id
//
//            print(postCatId)
////            performSegue(withIdentifier: "ProfileDetails", sender: postCatId)
//
//        }
//    }
//
    
//    func buttonTappedInCollectionViewCell(sender: UIButton) {
//        performSegue(withIdentifier: "ProfileDetails", sender: nil)
//    }
//
//
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ProfileDetails" {
//            if let backgroundViewCell = sender as? ProfileMyPostCell {
                if let playerVC = segue.destination as? Home2 {
                    playerVC.postCatId = "backgroundViewCell.dayName"
//                }
            }
        }
    }

    
    
  
    
}
