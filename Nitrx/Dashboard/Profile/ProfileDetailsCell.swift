//
//  ProfileDetailsCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 05/01/19.
//  Copyright © 2019 Nitrx. All rights reserved.
//

import UIKit

let blueColor = UIColor(red: 67/255, green: 80/255, blue: 255/255, alpha: 1)
let blueColor2 = UIColor(red: 25/255, green: 154/255, blue: 255/255, alpha: 1)

class ProfileDetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: CustomImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var count1: UILabel!
    @IBOutlet weak var count2: UILabel!
    @IBOutlet weak var count3: UILabel!
    @IBOutlet weak var count4: UILabel!
    
    @IBOutlet weak var des: UILabel!
    
    @IBOutlet weak var scoreImage: UIImageView!
    @IBOutlet weak var qrImage: CustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        edit.layer.borderColor = blueColor.cgColor
        edit.layer.borderWidth = 1
        edit.layer.cornerRadius = 4
        
    }
    
}
