//
//  PostDetailsPostButtonCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 22/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class PostDetailsPostButtonCell: UICollectionViewCell {
    
    @IBOutlet weak var postButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postButton.layer.cornerRadius = 4
        
    }
}
