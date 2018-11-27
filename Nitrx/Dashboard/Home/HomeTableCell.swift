//
//  HomeColCell.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 17/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//
/*
import UIKit

protocol CustomCellDelegate {
    func buttonPress(row: Int)
    func linkPress(row: Int)
}
class HomeTableCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var rating1: UIButton!
    //    @IBOutlet weak var rating2: UIButton!
    //    @IBOutlet weak var rating3: UIButton!
    //    @IBOutlet weak var rating4: UIButton!
    //    @IBOutlet weak var rating5: UIButton!
    
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var rank: UIButton!
    @IBOutlet weak var link: UIButton!
    @IBOutlet weak var postDetailsHeight: NSLayoutConstraint!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var desText: UILabel!
    @IBOutlet weak var viewPost: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var nitrxCount: UILabel!
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var postFile: UIImageView!
    @IBOutlet weak var subTable: UITableView!
    
    var showing = false
    var delegate: CustomCellDelegate?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        follow.layer.cornerRadius = 4
        rank.layer.cornerRadius = 4
        link.layer.cornerRadius = 16
        
        //        rating1.layer.borderWidth = 1
        //        rating1.layer.borderColor = UIColor.lightGray.cgColor
        //
        //        rating2.layer.borderWidth = 1
        //        rating2.layer.borderColor = UIColor.lightGray.cgColor
        //
        //        rating3.layer.borderWidth = 1
        //        rating3.layer.borderColor = UIColor.lightGray.cgColor
        //
        //        rating4.layer.borderWidth = 1
        //        rating4.layer.borderColor = UIColor.lightGray.cgColor
        //
        //        rating5.layer.borderWidth = 1
        //        rating5.layer.borderColor = UIColor.lightGray.cgColor
        
        subTable.delegate = self
        subTable.dataSource = self
    }
    
    
    @IBAction func expandPostDetails(_ sender: UIButton) {
        
        show()
    }
    
    @IBAction func linkClick(_ sender: UIButton) {
        
        
        delegate?.linkPress(row: sender.tag)
        
    }
    
    
    func show() {
        if showing {
            postDetailsHeight.constant = 200
            
            UIView.animate(withDuration: 0.3) {
                self.whiteView.layoutIfNeeded()
            }
        } else {
            postDetailsHeight.constant = 100
            UIView.animate(withDuration: 0.3) {
                self.whiteView.layoutIfNeeded()
            }
        }
        showing = !showing
    }
    
    @IBAction func rank(_ sender: UIButton) {
        
        delegate?.buttonPress(row: sender.tag)
    }
    
    
    
    // MARK : - Sub Table View Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubTableCell", for: indexPath) as! SubTableCell
        
//        cell.rank.tag = indexPath.row
//        cell.link.tag = indexPath.row
//        cell.follow.tag = indexPath.row
//
//        cell.postText.text = postArray[indexPath.row].postText
//        cell.link.setTitle(postArray[indexPath.row].website_url, for: .normal)
//        cell.username.text = postArray[indexPath.row].username
//        //        cell.desText.text = postArray[indexPath.row].description
//        cell.viewPost.text = String(postArray[indexPath.row].view)
//        cell.commentCount.text = String(postArray[indexPath.row].comment_count)
//        cell.nitrxCount.text = postArray[indexPath.row].nitrix_count
//        cell.qrImage.loadImageUsingUrlString(urlString: postArray[indexPath.row].qrimage)
//        cell.postFile.loadImageUsingUrlString(urlString: postArray[indexPath.row].postFile)
//
//        cell.delegate = self
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
}


*/
