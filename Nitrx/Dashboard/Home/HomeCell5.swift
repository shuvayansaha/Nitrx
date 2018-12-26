//
//  HomeCell5.swift
//  test2
//
//  Created by Shuvayan Saha on 25/11/18.
//  Copyright © 2018 Rplanx. All rights reserved.
//

import UIKit

protocol CommentCellDelegate {
    func commentPress(row: Int)
}

class HomeCell5: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    let imagePath = UserDefaults.standard.string(forKey: "Image-Path")

    var delegate: CommentCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        button1.RoundCornerButtonWithGrayBorder()
        button2.RoundCornerButtonWithGrayBorder()
        button3.RoundCornerButtonWithGrayBorder()
        button4.RoundCornerButtonWithGrayBorder()
        button5.RoundCornerButtonWithGrayBorder()
        
        if let img = imagePath {
            userImage.loadImageUsingUrlString(urlString: img)

        }
        

    }
  
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    @IBAction func commentButton(_ sender: UIButton) {
        delegate?.commentPress(row: sender.tag)
    }
    
}
    
