//
//  HomeCell4.swift
//  test2
//
//  Created by Shuvayan Saha on 25/11/18.
//  Copyright © 2018 Rplanx. All rights reserved.
//

import UIKit

protocol CommentsCellDelegate {
    
    func commentButtonPress(row: Int)
}

class HomeCell4: UITableViewCell {

    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var avarageRate: UIImageView!
    
    var commentsDelegate: CommentsCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func commentsAction(_ sender: UIButton) {
        
        commentsDelegate?.commentButtonPress(row: sender.tag)

    }
    
}
