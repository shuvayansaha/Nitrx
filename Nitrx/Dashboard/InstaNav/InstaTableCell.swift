//
//  InstaTableCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 19/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

var blankArray = [String]()

/*
 
 class InstaTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
 
    @IBOutlet weak var collection: UICollectionView!
    
    let array = ["1", "2", "3", "4", "5", "add-post-color", "angel-down"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(
                top: Constant.offset,    // top
                left: Constant.offset,    // left
                bottom: Constant.offset,    // bottom
                right: Constant.offset     // right
            )
            
            layout.minimumInteritemSpacing = Constant.minItemSpacing
            layout.minimumLineSpacing = Constant.minLineSpacing
        }

        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = false
        collection.allowsMultipleSelection = true

        Constant.totalItem = CGFloat(array.count)
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Constant.totalItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstaCollectionCell", for: indexPath) as! InstaCollectionCell
        
        cell.label.text = array[indexPath.row]
        cell.image.image = UIImage(named: array[indexPath.row])

        return cell
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemWidth = Constant.getItemWidth(boundWidth: collectionView.bounds.size.width)

        return CGSize(width: itemWidth, height: itemWidth)

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        if cell?.isSelected == true {
            
            cell?.backgroundColor = UIColor.orange
            blankArray.append(array[indexPath.row])
            
        } else {
            
            cell?.backgroundColor = UIColor.lightGray
            
            blankArray.removeAll { (element) -> Bool in
                element == array[indexPath.row]
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath)
        
        if cell?.isSelected == true {
            
            cell?.backgroundColor = UIColor.orange
            blankArray.append(array[indexPath.row])
            
        } else {
            
            cell?.backgroundColor = UIColor.lightGray
            
            blankArray.removeAll { (element) -> Bool in
                element == array[indexPath.row]
            }
        }

    }
    
    

    */

    
    
class InstaTableCell: UITableViewCell, UICollectionViewDataSource, GridLayoutDelegate {
    
    @IBOutlet weak var collection: UICollectionView!

//    var arrImages = [UIImage]()

    let arrImages = ["1", "2", "3", "4", "5", "add-post-color", "angel-down", "1", "2", "3", "4", "5", "add-post-color", "angel-down", "1", "2", "3", "4", "5", "add-post-color", "angel-down", "1", "2", "3", "4", "5", "add-post-color", "angel-down"]

    @IBOutlet var gridLayout: GridLayout!
    
    var arrInstaBigCells = [Int]()
    


    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Preparing array Of images
//        arrImages = Array(repeatElement(#imageLiteral(resourceName: "check"), count: 99))
        
        arrInstaBigCells.append(1)
        var tempStorage = false
        for _ in 1...21 {
            if(tempStorage){
                arrInstaBigCells.append(arrInstaBigCells.last! + 10)
            } else {
                arrInstaBigCells.append(arrInstaBigCells.last! + 8)
            }
            tempStorage = !tempStorage
        }
        
        print(arrInstaBigCells)
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collection.contentOffset = CGPoint(x: -10, y: -10)
        
        gridLayout.delegate = self
        gridLayout.itemSpacing = 3
        gridLayout.fixedDivisionCount = 3
        
         Constant.totalItem = CGFloat(arrImages.count)
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return arrImages.count
        return Int(Constant.totalItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstaCollectionCell", for: indexPath) as! InstaCollectionCell
        
        cell.image.image = UIImage(named: arrImages[indexPath.row])
        
        return cell
    }
    
    
    // MARK: - PrimeGridDelegate
    
    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt {
        if(arrInstaBigCells.contains(indexPath.row) || (indexPath.row == 1)) {
            return 2
        } else {
            return 1
        }
    }
    
    func itemFlexibleDimension(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, fixedDimension: CGFloat) -> CGFloat {
        
  
        
        return fixedDimension
    }
    
    

}
