//
//  HomeCell5.swift
//  test2
//
//  Created by Shuvayan Saha on 25/11/18.
//  Copyright © 2018 Rplanx. All rights reserved.
//

import UIKit

class HomeCell5: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var commentTextView: UITextField!
    //    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    var delegate: CustomCellDelegate?
//    var rateDelegate: CustomCellRateButtonDelegate?
    var commentDelegate: CustomCommentDelegate?
    
    var rateButtonNo = Int()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        button1.RoundCornerButton()
        button2.RoundCornerButton()
        button3.RoundCornerButton()
        button4.RoundCornerButton()
        button5.RoundCornerButton()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        

    }
    
   
    // comment send action
    @IBAction func commentSendAction(_ sender: UIButton) {
        commentDelegate?.commentBox(row: sender.tag, text: commentTextView.text!, rate: rateButtonNo)
    }
    
    

    var indexPath:IndexPath!
//
    @IBAction func btn1(_ sender: UIButton) {
        
        rateButtonNo = 1
        
        if (sender.isSelected)
        {
            sender.isSelected = false
            
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
        }
        else
        {
            sender.isSelected = true
        }
    
    }

    @IBAction func btn2(_ sender: UIButton) {
        
        rateButtonNo = 2

        if (sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
    }

    @IBAction func btn3(_ sender: UIButton) {
        
        rateButtonNo = 3

        if (sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
    }

    @IBAction func btn4(_ sender: UIButton) {
        
        rateButtonNo = 4

        if (sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
    }

    @IBAction func btn5(_ sender: UIButton) {
        
        rateButtonNo = 5

        if (sender.isSelected)
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
    }
    
    
    
    
}



// each edge round button
extension UIButton {
    func roundedButton() {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: 4, height: 4))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        layer.mask = maskLayer1

    }
}
