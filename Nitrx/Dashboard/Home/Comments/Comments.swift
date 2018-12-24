//
//  Comments.swift
//  Nitrx
//
//  Created by Rplanx on 10/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Comments: UIViewController, UITableViewDataSource, UITableViewDelegate, ReplyButtonDelegate {
  
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendComment: UIButton!

    var post_id = String()
    var profile_id = String()

    var commentArray = [CommentsClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()

        commentsTable.delegate = self
        commentsTable.dataSource = self
        
        print("post_id ***", post_id)
        
        loadComments(post_id: post_id) {
            self.commentsTable.reloadData()
        }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell") as! CommentsCell

        cell.commentText.text = commentArray[indexPath.row].text
        cell.time.text = commentArray[indexPath.row].time
        cell.name.text = commentArray[indexPath.row].username
        
        if let img = commentArray[indexPath.row].user_avater {
            
            cell.userImage.loadImageUsingUrlString(urlString: img)

        } else {
            
            cell.userImage.image = nil
        }
        
        cell.replyButton.tag = indexPath.row
        cell.delegate = self
        

        cell.comment_reply = commentArray[indexPath.row].comment_reply!

        cell.replyTable.reloadData()


        return cell
    }
    

//
//    // reply comment
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if (segue.identifier == "ReplySegue") {
//            let vc = segue.destination as! ReplyComment
//            vc.comment_reply = commentArray[sender as! Int].comment_reply!
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let cellHeight = 3 + 8 + 21 + 3 + 21 + 3 + 15 + 3

        if let replyCount = commentArray[indexPath.row].comment_reply?.count {

            let totalHeight = cellHeight + (replyCount * cellHeight)

            return CGFloat(totalHeight)

        } else {
            return UITableView.automaticDimension
        }

    }
  
    var reply = false
    var replyRow = Int()

    @IBAction func messageSend(_ sender: UIButton) {
        
        print(reply, replyRow)
        
        if reply == true {
            
            let comment_id = commentArray[replyRow].comment_id
            
            postCommentReply(userId: profile_id, text: commentTextField.text!, comment_id: comment_id!) {
                self.loadComments(post_id: self.post_id) {
                    self.commentsTable.reloadData()
                    
                    self.scrollToBottom()
                    
                }
            }
            
        } else {
            
            postComment(postId: post_id, userId: profile_id, text: commentTextField.text!) {
                self.loadComments(post_id: self.post_id) {
                    self.commentsTable.reloadData()
                    
                    self.scrollToBottom()
                    
                }
            }
            
        }
        
        
    }
    
    
    func buttonPress(section: Int) {
        
        reply = true
        replyRow = section

        commentTextField.becomeFirstResponder()
    }
    
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.commentArray.count-1, section: 0)
            self.commentsTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    // tableview scroll event
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        view.endEditing(true)
    }
    
    
    
    // load comments
    func loadComments(post_id: String, completed: @escaping () -> ()) {

        let url = baseURL + comment + "?" + "post_id=" + "\(post_id)"

        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in

//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([CommentsClass].self, from: data)
                
                self.commentArray = getData
                
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    
    
    // comment box
    func postComment(postId: String, userId: String, text: String, completed: @escaping () -> ()) {
        
        let url = baseURL + save_comment + "?"
            + "post_id="
            + "\(postId)"
            + "&user_id="
            + "\(userId)"
            + "&action="
            + "comment_user"
            + "&text="
            + "\(text)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([SendCommentsClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
                        self.commentTextField.text = ""
                        self.view.endEditing(true)
                        
                    } else {
                        
                        if let err = i.errors?.error_text {
                            snackBarFunction(message: err)
                        }
                    }
                }
                
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    
    // comment reply box
    func postCommentReply(userId: String, text: String, comment_id: String, completed: @escaping () -> ()) {
        
        let url = baseURL + save_comment + "?"
            + "comment_id="
            + "\(comment_id)"
            + "&user_id="
            + "\(userId)"
            + "&action="
            + "comment-reply-user"
            + "&text="
            + "\(text)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([SendCommentsClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
                        self.commentTextField.text = ""
                        self.view.endEditing(true)
                        self.reply = false

                    } else {
                        
                        if let err = i.errors?.error_text {
                            snackBarFunction(message: err)
                        }
                    }
                }
                
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    
    
}
