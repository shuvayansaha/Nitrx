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
    var rateDelegate: CustomCellRateButtonDelegate?
    var commentDelegate: CustomCommentDelegate?
    
    var rateButtonNo = Int()

    let imagePath = UserDefaults.standard.string(forKey: "Image-Path")

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
    
    
    
    @IBAction func rateButtonAction(_ sender: UIButton) {
        
        rateDelegate?.rateButtonPress(senderTag: sender.tag)
        
        
        if sender.tag == 1 {
            
            button1.setImage(UIImage(named: "avater1-white"), for: .normal)
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if sender.tag == 2 {
            
            button1.setImage(UIImage(named: "avater1"), for: .normal)
            button2.setImage(UIImage(named: "avater2-white"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if sender.tag == 3 {
            
            button1.setImage(UIImage(named: "avater1"), for: .normal)
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car-white"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if sender.tag == 4 {
            
            button1.setImage(UIImage(named: "avater1"), for: .normal)
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster-white"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if sender.tag == 5 {
            
            button1.setImage(UIImage(named: "avater1"), for: .normal)
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3-white"), for: .normal)
            
        }
        
    }
    
    
}
    
    
//
//    @IBAction func btn1(_ sender: UIButton) {
//
//        rateButtonNo = 1
//
//        if (sender.isSelected)
//        {
//            sender.isSelected = false
//
//            button2.setImage(UIImage(named: "avater2"), for: .normal)
//            button3.setImage(UIImage(named: "car"), for: .normal)
//            button4.setImage(UIImage(named: "booster"), for: .normal)
//            button5.setImage(UIImage(named: "avater3"), for: .normal)
//        }
//        else
//        {
//            sender.isSelected = true
//        }
//
//    }
//
//    @IBAction func btn2(_ sender: UIButton) {
//
//        rateButtonNo = 2
//
//        if (sender.isSelected)
//        {
//            sender.isSelected = false
//        }
//        else
//        {
//            sender.isSelected = true
//        }
//    }
//
//    @IBAction func btn3(_ sender: UIButton) {
//
//        rateButtonNo = 3
//
//        if (sender.isSelected)
//        {
//            sender.isSelected = false
//        }
//        else
//        {
//            sender.isSelected = true
//        }
//    }
//
//    @IBAction func btn4(_ sender: UIButton) {
//
//        rateButtonNo = 4
//
//        if (sender.isSelected)
//        {
//            sender.isSelected = false
//        }
//        else
//        {
//            sender.isSelected = true
//        }
//    }
//
//    @IBAction func btn5(_ sender: UIButton) {
//
//        rateButtonNo = 5
//
//        if (sender.isSelected)
//        {
//            sender.isSelected = false
//        }
//        else
//        {
//            sender.isSelected = true
//        }
//    }




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
