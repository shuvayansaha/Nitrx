//
//  TermsOfServiceButtonCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 22/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class TermsOfServiceButtonCell: UICollectionViewCell {
    
    @IBOutlet weak var accept: UIButton!
    var delegate: CustomCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        accept.layer.cornerRadius = 4
        
    }
    
    // accept button
    @IBAction func accept(_ sender: UIButton) {
    
        delegate?.buttonPress(row: sender.tag)

    }
    
}
