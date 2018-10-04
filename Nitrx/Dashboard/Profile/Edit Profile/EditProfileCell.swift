//
//  EditProfileCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 30/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class EditProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var changePicture: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 4
        
        changePicture.layer.cornerRadius = 20
    }
    
}
