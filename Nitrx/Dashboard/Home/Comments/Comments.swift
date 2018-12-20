//
//  Comments.swift
//  Nitrx
//
//  Created by Rplanx on 10/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Comments: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let reply = commentArray[section].comment_reply?.count {
            
            return reply + 1

        } else {
            
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell") as! CommentsCell

        cell.commentText.text = commentArray[indexPath.section].text
        cell.time.text = commentArray[indexPath.section].time
        cell.name.text = commentArray[indexPath.section].username
        
        if let img = commentArray[indexPath.section].user_avater {
            
            cell.userImage.loadImageUsingUrlString(urlString: img)

        } else {
            
            cell.userImage.image = nil
        }
        
    

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  
    
    @IBAction func messageSend(_ sender: UIButton) {
        
//        print("post_id ***", post_id, commentTextField.text!)
        
        if commentTextField.text! != "" {
            
            postComment(postId: post_id, userId: profile_id, text: commentTextField.text!) {
                self.loadComments(post_id: self.post_id) {
                    self.commentsTable.reloadData()
                    
                    self.scrollToBottom()
                
                }
                
            }

        }
        
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

            print(stringData)
            
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
            + "\("comment_user")"
            + "&text="
            + "\(text)"
        
        print(url)
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for json in jsonObject! {
                    
                    if let jsonDic = json as? [String: Any] {
                        
                        if jsonDic["success"] as? Int == 200 {
                            
                            //                                self.performSegue(withIdentifier: "CommentsSegue", sender: row)
                            self.commentTextField.text = ""
//                            self.view.endEditing(true)
                            
                            
                        } else {
                            
                            if jsonDic["errors"] != nil {
                                
                                let errors = jsonDic["errors"] as! [String: Any]
                                let error = errors["error_text"] as! String
                                
                                snackBarFunction(message: error)
                                
                            }
                            
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
