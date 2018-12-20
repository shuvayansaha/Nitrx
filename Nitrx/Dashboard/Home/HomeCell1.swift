//
//  HomeCell1.swift
//  test2
//
//  Created by Shuvayan Saha on 24/11/18.
//  Copyright © 2018 Rplanx. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    
    func buttonPress(row: Int)
    func linkPress(row: Int)

}

protocol CustomCommentDelegate {
    func commentBox(row: Int, text: String, rate: Int)
    
}

protocol CustomCellRateButtonDelegate {
    
//    func rateButton1Press(row: Int, button: Int)
//    func rateButton2Press(row: Int, button: Int)
//    func rateButton3Press(row: Int, button: Int)
//    func rateButton4Press(row: Int, button: Int)
//    func rateButton5Press(row: Int, button: Int)

//    func closeFriendsTapped(at index:IndexPath)

    func rateButtonPress(row: Int, at index: IndexPath)
}


class HomeCell1: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var rankButton: UIButton!
    @IBOutlet weak var postFile: UIImageView!
    
    @IBOutlet weak var nitrxCount: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
   
        rankButton.RoundCornerButton()
        followButton.RoundCornerButton()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
