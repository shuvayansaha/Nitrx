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
    func commentBox(row: Int)
}


protocol CustomCellRateButtonDelegate {
    
    func rateButton1Press(row: Int)
    func rateButton2Press(row: Int)
    func rateButton3Press(row: Int)
    func rateButton4Press(row: Int)
    func rateButton5Press(row: Int)

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
        
   

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
