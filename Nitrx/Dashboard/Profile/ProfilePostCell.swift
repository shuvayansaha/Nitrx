//
//  ProfilePostCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 05/01/19.
//  Copyright © 2019 Nitrx. All rights reserved.
//

import UIKit

protocol PostDelEditDelegate {
    func postEdit(row: Int)
    func postDel(row: Int)

}

class ProfilePostCell: UICollectionViewCell {
   
    @IBOutlet weak var image: CustomImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var editDelView: UIStackView!
    @IBOutlet weak var editPostButton: UIButton!
    @IBOutlet weak var deletePostButton: UIButton!

    var postDelEditDel: PostDelEditDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editDelView.isHidden = true
    }
    
    @IBAction func postEditDel(_ sender: UIButton) {
        editDelView.isHidden = !editDelView.isHidden
    }
    
    
    @IBAction func editPost(_ sender: UIButton) {
        postDelEditDel?.postEdit(row: sender.tag)
        editDelView.isHidden = !editDelView.isHidden

    }
    
    @IBAction func deletePost(_ sender: UIButton) {
        postDelEditDel?.postDel(row: sender.tag)
        editDelView.isHidden = !editDelView.isHidden

    }
    
}
