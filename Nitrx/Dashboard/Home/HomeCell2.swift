//
//  HomeCell2.swift
//  test2
//
//  Created by Shuvayan Saha on 24/11/18.
//  Copyright © 2018 Rplanx. All rights reserved.
//

import UIKit

class HomeCell2: UITableViewCell {

    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postLinkButton: UIButton!
    @IBOutlet weak var qrImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
