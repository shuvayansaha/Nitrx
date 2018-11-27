//
//  HomeCell4.swift
//  test2
//
//  Created by Shuvayan Saha on 25/11/18.
//  Copyright © 2018 Rplanx. All rights reserved.
//

import UIKit

class HomeCell4: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        whiteView.addRightBorderWithColor(color: UIColor.lightGray, width: 0.5)
        whiteView.addLeftBorderWithColor(color: UIColor.lightGray, width: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
