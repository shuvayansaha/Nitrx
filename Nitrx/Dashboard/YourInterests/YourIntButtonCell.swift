//
//  YourIntButtonCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 15/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class YourIntButtonCell: UICollectionViewCell {
    
    @IBOutlet weak var confirmChoices: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        confirmChoices.RoundCornerButton()
    }
    
    @IBAction func confirmChoice(_ sender: UIButton) {
        
        
    }
    
    @IBAction func backToPrev(_ sender: UIButton) {
    }
}
