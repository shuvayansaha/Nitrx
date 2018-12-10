//
//  HomeCell5.swift
//  test2
//
//  Created by Shuvayan Saha on 25/11/18.
//  Copyright © 2018 Rplanx. All rights reserved.
//

import UIKit

class HomeCell5: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var clickCommentBox: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    var delegate: CustomCellDelegate?
    var rateDelegate: CustomCellRateButtonDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


        
        button1.RoundCornerButton()
        button2.RoundCornerButton()
        button3.RoundCornerButton()
        button4.RoundCornerButton()
        button5.RoundCornerButton()
        
    
        
//        button1.setImage(UIImage(named: "avater1-white"), for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickCommentBox(_ sender: UIButton) {
    
        delegate?.commentBox(row: sender.tag)
    }
    
    
    
    @IBAction func btn1(_ sender: UIButton) {
        rateDelegate?.rateButton1Press(row: sender.tag)
    }
    
    @IBAction func btn2(_ sender: UIButton) {
        rateDelegate?.rateButton1Press(row: sender.tag)
    }
    
    @IBAction func btn3(_ sender: UIButton) {
        rateDelegate?.rateButton1Press(row: sender.tag)
    }
    
    @IBAction func btn4(_ sender: UIButton) {
        rateDelegate?.rateButton1Press(row: sender.tag)
    }
    
    @IBAction func btn5(_ sender: UIButton) {
        rateDelegate?.rateButton1Press(row: sender.tag)
    }
    
    @IBAction func rateButton(_ sender: UIButton) {
                
//        delegate?.rateButtonPress(row: sender.tag)
        
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
