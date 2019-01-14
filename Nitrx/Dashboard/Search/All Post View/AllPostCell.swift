//
//  AllPostCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 12/01/19.
//  Copyright © 2019 Nitrx. All rights reserved.
//

import UIKit

class AllPostCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: CustomImageView!
    @IBOutlet weak var rate: UIButton!
    
    var rateDelegate: SearchRateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rate.layer.cornerRadius = 0.5 * rate.bounds.size.width
        rate.clipsToBounds = true
    }
    
    
    
    @IBAction func rateAction(_ sender: UIButton) {
        
        rateDelegate?.allPostRate(row: sender.tag)
    }
}
