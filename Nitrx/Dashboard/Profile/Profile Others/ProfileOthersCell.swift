//
//  ProfileOthersCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 09/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class ProfileOthersCell: UICollectionViewCell {

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
        

        
    }
}
