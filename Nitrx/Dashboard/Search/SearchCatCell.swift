//
//  SearchCatCell.swift
//  Nitrx
//
//  Created by Rplanx on 24/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
let blue = UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1)

class SearchCatCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        label.layer.borderColor = blue.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 16
    }
}
