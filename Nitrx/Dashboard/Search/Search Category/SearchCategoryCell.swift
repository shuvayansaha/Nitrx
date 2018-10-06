//
//  SearchCategoryCell.swift
//  Nitrx
//
//  Created by Rplanx on 06/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class SearchCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    let blue = UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1).cgColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        label.layer.borderColor = blue
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 16
    }
    
    
}
