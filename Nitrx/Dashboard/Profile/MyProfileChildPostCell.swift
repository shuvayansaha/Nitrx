//
//  MyProfileChildPostCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 22/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

protocol ProfilePostClick {
    func imageClickFunction(indexPath: IndexPath)
}

class MyProfileChildPostCell: UICollectionViewCell {
   
    @IBOutlet weak var image: CustomImageView!
    @IBOutlet weak var label: UILabel!
    
    var profileDel: ProfilePostClick?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
  
}
