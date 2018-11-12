//
//  HomeColCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 17/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func buttonPress(row: Int)
    func linkPress(row: Int)
}
class HomeColCell: UICollectionViewCell {
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var rating1: UIButton!
//    @IBOutlet weak var rating2: UIButton!
//    @IBOutlet weak var rating3: UIButton!
//    @IBOutlet weak var rating4: UIButton!
//    @IBOutlet weak var rating5: UIButton!

    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var rank: UIButton!
    @IBOutlet weak var link: UIButton!
    @IBOutlet weak var postDetailsHeight: NSLayoutConstraint!
    @IBOutlet weak var postText: UILabel!
    
    var showing = false
    var delegate: CustomCellDelegate?

   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        follow.layer.cornerRadius = 4
        rank.layer.cornerRadius = 4
        link.layer.cornerRadius = 16

//        rating1.layer.borderWidth = 1
//        rating1.layer.borderColor = UIColor.lightGray.cgColor
//        
//        rating2.layer.borderWidth = 1
//        rating2.layer.borderColor = UIColor.lightGray.cgColor
//        
//        rating3.layer.borderWidth = 1
//        rating3.layer.borderColor = UIColor.lightGray.cgColor
//        
//        rating4.layer.borderWidth = 1
//        rating4.layer.borderColor = UIColor.lightGray.cgColor
//
//        rating5.layer.borderWidth = 1
//        rating5.layer.borderColor = UIColor.lightGray.cgColor
        
       
    }
  
  
    @IBAction func expandPostDetails(_ sender: UIButton) {
        
        show()
    }
    
    @IBAction func linkClick(_ sender: UIButton) {

        
        delegate?.linkPress(row: sender.tag)

    }
    
    
    func show() {
        if showing {
            postDetailsHeight.constant = 200
            
            UIView.animate(withDuration: 0.3) {
                self.whiteView.layoutIfNeeded()
            }
        } else {
            postDetailsHeight.constant = 100
            UIView.animate(withDuration: 0.3) {
                self.whiteView.layoutIfNeeded()
            }
        }
        showing = !showing
    }
    
    @IBAction func rank(_ sender: UIButton) {
        
        delegate?.buttonPress(row: sender.tag)
    }
    
    
}
