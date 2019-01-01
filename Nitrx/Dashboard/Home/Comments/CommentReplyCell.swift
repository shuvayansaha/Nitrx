//
//  CommentReplyCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 21/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class CommentReplyCell: UITableViewCell {

    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var userImage: CustomImageView!
    @IBOutlet weak var replyButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
