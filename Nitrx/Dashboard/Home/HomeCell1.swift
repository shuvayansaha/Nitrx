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
class HomeCell1: UITableViewCell {
    
    @IBOutlet weak var whiteView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        whiteView.addTopBorderWithColor(color: UIColor.lightGray, width: 0.5)
        whiteView.addRightBorderWithColor(color: UIColor.lightGray, width: 0.5)
        whiteView.addLeftBorderWithColor(color: UIColor.lightGray, width: 0.5)
        whiteView.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.5)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
