//
//  Home2.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 31/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import WebKit

class Home2: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDel, RateDel {
 
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    let imagePath = UserDefaults.standard.string(forKey: "Image-Path")

    var postArray = [PostsClass]()

    @IBOutlet weak var homeTableView: UITableView!
    
    var imageView = UIImageView()
    let web = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self

        loadHome {
            self.homeTableView.reloadData()
        }
        
        
        // custom navigation bar right side icon
        let pencilBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        pencilBtn.setImage(UIImage(named: "massege-white"), for: [])
        pencilBtn.addTarget(self, action: #selector(notification), for: UIControl.Event.touchUpInside)
        pencilBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let pencilButton = UIBarButtonItem(customView: pencilBtn)
        
        self.navigationItem.rightBarButtonItems = [pencilButton]
        
        // navigation bar logo centre
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        web.frame  = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // navigation bar gradient color
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }

    @objc func notification() {
        print("wallet")
    }
    
    
    
    
    func commentTextFunction(indexPath: IndexPath) {
        
        let cell = homeTableView.cellForRow(at: indexPath) as! HomeSubCell
        
        let post_id = postArray[indexPath.row].post_id
        let commentText = cell.commentTextField.text
        
        var commentRate = Int()
        if cell.rate != nil {
            
            commentRate = cell.rate!
        }
        
        let url = baseURL + save_comment + "?"
            + "post_id="
            + "\(post_id!)"
            + "&user_id="
            + "\(user_id!)"
            + "&action="
            + "\("comment_user")"
            + "&text="
            + "\(commentText!)"
            + "&rate_post="
            + "\(commentRate)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([CreatePostClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
                        cell.commentTextField.text = ""
                        self.performSegue(withIdentifier: "CommentsSegue", sender: self.index)
                        
                    } else {
                        
                        if let err = i.errors?.error_text {
                            snackBarFunction(message: err)
                        }
                    }
                }
                
                //                DispatchQueue.main.async { completed() }
                
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    func rateFunction(indexPath: IndexPath) {
        
        let cell = homeTableView.cellForRow(at: indexPath) as! HomeSubCell
      
        if cell.rate == 1 {
            
           cell.rate1.setImage(UIImage(named: "avater1-white"), for: .normal)
           cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
           cell.rate3.setImage(UIImage(named: "car"), for: .normal)
           cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
           cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if cell.rate == 2 {
            
            cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
            cell.rate2.setImage(UIImage(named: "avater2-white"), for: .normal)
            cell.rate3.setImage(UIImage(named: "car"), for: .normal)
            cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
            cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if cell.rate == 3 {
            
            cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
            cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
            cell.rate3.setImage(UIImage(named: "car-white"), for: .normal)
            cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
            cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if cell.rate == 4 {
            
            cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
            cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
            cell.rate3.setImage(UIImage(named: "car"), for: .normal)
            cell.rate4.setImage(UIImage(named: "booster-white"), for: .normal)
            cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if cell.rate == 5 {
            
            cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
            cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
            cell.rate3.setImage(UIImage(named: "car"), for: .normal)
            cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
            cell.rate5.setImage(UIImage(named: "avater3-white"), for: .normal)
            
        }
    }
    
    
    
    // MARK : - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubCell", for: indexPath) as! HomeSubCell
        
        cell.tapDelegate = self
        cell.rateDelegate = self
        cell.indexPath = indexPath
        
        
        cell.username.text = postArray[indexPath.row].first_name! + " " + postArray[indexPath.section].last_name!
        cell.postedDate.text = postArray[indexPath.row].post_date
        cell.postImage.loadImageUsingUrlString(urlString: postArray[indexPath.row].image!)
        cell.userImage.loadImageUsingUrlString(urlString: postArray[indexPath.row].user_avatar!)
        cell.viewCount.text = "\((postArray[indexPath.row].view_count)!)"
        cell.commentCount.text = "\((postArray[indexPath.row].comments)!)"
        cell.qrImage.loadImageUsingUrlString(urlString: postArray[indexPath.row].qrimage!)
        cell.postText.text = postArray[indexPath.row].postText
        cell.postLinkButton.setTitle(postArray[indexPath.row].website_url, for: .normal)
        cell.postDescription.text = postArray[indexPath.row].description
        cell.commentCount.text = "\((postArray[indexPath.row].comments)!)"
        
        if let img = imagePath {
            cell.userImageInComment.loadImageUsingUrlString(urlString: img)
        }
        
        let avg_post_rate = postArray[indexPath.row].avg_post_rate
        
        if avg_post_rate == 1 {
            cell.avarageRate.image = UIImage(named: "avater1-white")
        } else if avg_post_rate == 2 {
            cell.avarageRate.image = UIImage(named: "avater2-white")
        } else if avg_post_rate == 3 {
            cell.avarageRate.image = UIImage(named: "car-white")
        } else if avg_post_rate == 4 {
            cell.avarageRate.image = UIImage(named: "booster-white")
        } else if avg_post_rate == 5 {
            cell.avarageRate.image = UIImage(named: "avater3-white")
        } else {
            cell.avarageRate.image = nil
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }

    
    
    
    
    //load home data
    func loadHome(completed: @escaping () -> ()) {
        
        let url = baseURL + post_details
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            //            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([PostsClass].self, from: data)
                
                self.postArray = getData
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // keyboard show and hide
    @objc func keyboardWillShow(notification: NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = homeTableView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        homeTableView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        homeTableView.contentInset = contentInset
    }
}
