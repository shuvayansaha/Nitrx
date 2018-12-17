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

    var post_id = String()
    var commentArray = [CommentsClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  
    
    
    
    // load comments
    func loadComments(post_id: String, completed: @escaping () -> ()) {

        let url = baseURL + comment + "?" + "post_id=" + "\(post_id)"

        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in

            
            print(stringData)
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for post in jsonObject! {

                    let postDic = post as? [String: Any]

                    if postDic != nil {

                        let postData = CommentsClass()


                        if postDic?["text"] != nil {
                            postData.text = postDic?["text"] as! String
                        }
                        
                        
                        self.commentArray.append(postData)

                    }
                }
                
                DispatchQueue.main.async {
                    
                    completed()
                }
                
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    
    
    
    
}
