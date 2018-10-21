//
//  InstaCollectionCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 19/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class InstaCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }
}
