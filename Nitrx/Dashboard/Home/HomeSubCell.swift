//
//  HomeSubCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 31/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

protocol CellDel {
    
    func commentTextFunction(indexPath: IndexPath)
}

protocol RateDel {
    
    func rateFunction(indexPath: IndexPath)
}

protocol ShowComments {
    
    func showCommentsFunction(indexPath: IndexPath)
}

protocol OpenWebView {
    
    func webViewFunction(indexPath: IndexPath)
}

protocol PostRateFollowDelegate {
    
    func ratePostFunction(indexPath: IndexPath)
    func followPostFunction(indexPath: IndexPath)
}



class HomeSubCell: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var userImage: CustomImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var postImage: CustomImageView!
    
    @IBOutlet weak var followButton: UIButton!

    @IBOutlet weak var nitrxCount: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var rankButton: UIButton!

    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postLinkButton: UIButton!
    @IBOutlet weak var qrImage: CustomImageView!
    
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var desExpandButton: UIButton!
    
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var avarageRate: CustomImageView!
    
    @IBOutlet weak var userImageInComment: CustomImageView!
    @IBOutlet weak var commentPostButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var rate1: UIButton!
    @IBOutlet weak var rate2: UIButton!
    @IBOutlet weak var rate3: UIButton!
    @IBOutlet weak var rate4: UIButton!
    @IBOutlet weak var rate5: UIButton!
    
    var tapDelegate: CellDel?
    var rateDelegate: RateDel?
    var showCommentsDelegate: ShowComments?
    var openWebViewDelegate: OpenWebView?
    var rateFollowDelegate: PostRateFollowDelegate?

    var indexPath: IndexPath?
    var rate: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        postLinkButton.layer.cornerRadius = 14
        
        rate1.RoundCornerButtonWithGrayBorder()
        rate2.RoundCornerButtonWithGrayBorder()
        rate3.RoundCornerButtonWithGrayBorder()
        rate4.RoundCornerButtonWithGrayBorder()
        rate5.RoundCornerButtonWithGrayBorder()
        
        rankButton.RoundCornerButton()
        followButton.RoundCornerButton()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func rateButtonAction(_ sender: UIButton) {
    
        rate = sender.tag
        rateDelegate?.rateFunction(indexPath: indexPath!)
    }
    
    
    @IBAction func commentPostButton(_ sender: UIButton) {
    
        tapDelegate?.commentTextFunction(indexPath: indexPath!)
    }
    
   
    @IBAction func showAllComments(_ sender: UIButton) {
    
        showCommentsDelegate?.showCommentsFunction(indexPath: indexPath!)
    }
    
    @IBAction func webLinkbutton(_ sender: UIButton) {
        
        openWebViewDelegate?.webViewFunction(indexPath: indexPath!)

    }
    
    
    @IBAction func postRateAction(_ sender: UIButton) {
        rateFollowDelegate?.ratePostFunction(indexPath: indexPath!)
    }
    
    @IBAction func followAction(_ sender: UIButton) {
        rateFollowDelegate?.followPostFunction(indexPath: indexPath!)
    }
}
