//
//  ProfileColCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 22/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

let blueColor = UIColor(red: 67/255, green: 80/255, blue: 255/255, alpha: 1)
let blueColor2 = UIColor(red: 25/255, green: 154/255, blue: 255/255, alpha: 1)

class ProfileColCell: UICollectionViewCell {

    @IBOutlet weak var tag1: UIButton!
    @IBOutlet weak var tag2: UIButton!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var whiteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        edit.layer.borderColor = blueColor.cgColor
        edit.layer.borderWidth = 1
        edit.layer.cornerRadius = 4
        
        tag1.layer.borderColor = blueColor2.cgColor
        tag1.layer.borderWidth = 1
        tag1.layer.cornerRadius = 16
        
        tag2.layer.borderColor = blueColor2.cgColor
        tag2.layer.borderWidth = 1
        tag2.layer.cornerRadius = 16
        
    }
}
