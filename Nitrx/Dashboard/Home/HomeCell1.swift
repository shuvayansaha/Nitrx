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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
