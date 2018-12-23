//
//  CommentsCell.swift
//  Nitrx
//
//  Created by Rplanx on 10/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

protocol ReplyButtonDelegate {
    func buttonPress(section: Int)
}

class CommentsCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var replyTable: UITableView!
    
    var delegate: ReplyButtonDelegate?

    var comment_reply = [CommentsReplyClass]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        replyTable.delegate = self
        replyTable.dataSource = self

                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func replyButtonAction(_ sender: UIButton) {
        
        delegate?.buttonPress(section: sender.tag)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment_reply.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentReplyCell", for: indexPath) as! CommentReplyCell
        
        cell.commentText.text = comment_reply[indexPath.row].text
        cell.time.text = comment_reply[indexPath.row].time
        cell.name.text = comment_reply[indexPath.row].username
        
        if let img = comment_reply[indexPath.row].user_avater {
            
            cell.userImage.loadImageUsingUrlString(urlString: img)
            
        } else {
            
            cell.userImage.image = nil
        }
        
//        cell.replyButton.tag = indexPath.row
//        cell.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


