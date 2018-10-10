//
//  PostDetailsCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 22/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class PostDetailsCell: UICollectionViewCell, UITextViewDelegate {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var upload: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var postView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 4
        
        textView.delegate = self
        textView.text = "Describe your post here..."
        textView.textColor = UIColor.lightGray
        
//        textView.becomeFirstResponder()
//
//        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        
        upload.layer.cornerRadius = 4
        
        save.layer.borderColor = blueColor2.cgColor
        save.layer.borderWidth = 1
        save.layer.cornerRadius = 4
        
        postView.layer.borderColor = UIColor.lightGray.cgColor
        postView.layer.borderWidth = 0.5
        postView.layer.cornerRadius = 4
        
        
//        let yourViewBorder = CAShapeLayer()
//        yourViewBorder.strokeColor = UIColor.lightGray.cgColor
//        yourViewBorder.lineDashPattern = [2, 2]
//        yourViewBorder.frame = postView.bounds
//        yourViewBorder.fillColor = nil
//        yourViewBorder.path = UIBezierPath(rect: postView.bounds).cgPath
//        yourViewBorder.masksToBounds = true
//        yourViewBorder.masksToBounds = true
//
//        postView.layer.addSublayer(yourViewBorder)

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describe your post here..."
            textView.textColor = UIColor.lightGray
        }
    }

    
    
 

    
}
