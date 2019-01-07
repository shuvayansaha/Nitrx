//
//  SearchPostCatCell.swift
//  Nitrx
//
//  Created by Rplanx on 24/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

protocol SearchRateDelegate {
    func rate(row: Int)
}

class SearchPostCatCell: UICollectionViewCell {
    
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
        
        rateDelegate?.rate(row: sender.tag)
    }
}
