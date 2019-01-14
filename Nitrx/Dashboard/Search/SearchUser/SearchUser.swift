//
//  SearchUser.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 08/01/19.
//  Copyright © 2019 Nitrx. All rights reserved.
//

import UIKit

class SearchUser: UITableViewCell {

    @IBOutlet weak var userImage: CustomImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
