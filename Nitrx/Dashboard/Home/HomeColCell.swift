//
//  HomeColCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 17/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class HomeColCell: UICollectionViewCell {
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var rank: UIButton!
    @IBOutlet weak var link: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        follow.layer.cornerRadius = 4
        rank.layer.cornerRadius = 4
        link.layer.cornerRadius = 10

        
    }
  

}
