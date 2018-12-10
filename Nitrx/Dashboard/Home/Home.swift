//
//  Home.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 16/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import WebKit

class Home: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomCellDelegate, CustomCellRateButtonDelegate, CommentsCellDelegate {
 
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet var ratePopUp: UIView!

    let web = WKWebView()
    
    var closeButton = UIBarButtonItem()
    var imageView = UIImageView()
    var postArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTable.delegate = self
        homeTable.dataSource = self
        
        userDefaultsFunc()
        
        loadHome {
            self.homeTable.reloadData()
        }
        
        // custom navigation bar right side icon
        let pencilBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        pencilBtn.setImage(UIImage(named: "notification"), for: [])
        pencilBtn.addTarget(self, action: #selector(notification), for: UIControl.Event.touchUpInside)
        pencilBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let pencilButton = UIBarButtonItem(customView: pencilBtn)
        
        // custom navigation bar left side icon
        let closeBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        closeBtn.setImage(UIImage(named: "cross-white"), for: [])
        closeBtn.addTarget(self, action: #selector(closeWeb), for: UIControl.Event.touchUpInside)
        closeBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        closeButton = UIBarButtonItem(customView: closeBtn)
        
        self.navigationItem.rightBarButtonItems = [pencilButton]
        
        // navigation bar logo centre
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        web.frame  = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        self.navigationController?.navigationBar.isTranslucent = false
        //        self.tabBarController?.tabBar.isTranslucent = false
        
    }
    
    
    func userDefaultsFunc() {
        
        //        let Address = UserDefaults.standard.string(forKey: "Address")
        //        let DOB = UserDefaults.standard.string(forKey: "DOB")
        //        let email = UserDefaults.standard.string(forKey: "email")
        //        let FirstName = UserDefaults.standard.string(forKey: "FirstName")
        //        let followPrivacy = UserDefaults.standard.string(forKey: "followPrivacy")
        //        let ImagePath = UserDefaults.standard.string(forKey: "ImagePath")
        //        let JoinDate = UserDefaults.standard.string(forKey: "JoinDate")
        //        let LastName = UserDefaults.standard.string(forKey: "LastName")
        //        let qrimage = UserDefaults.standard.string(forKey: "qrimage")
        //        let status = UserDefaults.standard.string(forKey: "status")
        //        let UserType = UserDefaults.standard.string(forKey: "UserType")
        //        let username = UserDefaults.standard.string(forKey: "username")
        //        let user_id = UserDefaults.standard.string(forKey: "user_id")
        //        let verified = UserDefaults.standard.string(forKey: "verified")
        //        let Wallet = UserDefaults.standard.string(forKey: "Wallet")
        
        
        //        print("Address", Address!)
        //        print("DOB", DOB!)
        //        print("email", email!)
        //        print("FirstName", FirstName!)
        //        print("followPrivacy", followPrivacy!)
        //        print("ImagePath", ImagePath!)
        //        print("JoinDate", JoinDate!)
        //        print("LastName", LastName!)
        //        print("qrimage", qrimage!)
        //        print("status", status!)
        //        print("UserType", UserType!)
        //        print("username", username!)
        //        print("user_id", user_id!)
        //        print("verified", verified!)
        //        print("Wallet", Wallet!)
        
    }
    
    @objc func notification() {
        print("wallet")
    }
    
    @objc func closeWeb() {
        
        if let viewWithTag = self.view.viewWithTag(74) {
            viewWithTag.removeFromSuperview()
            self.navigationItem.leftBarButtonItems = nil
            navigationItem.titleView = imageView
            
        } else{
            print("No!")
        }
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // navigation bar gradient color
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }
    
    
    func rateButton1Press(row: Int) {
        print(row)
    }
    
    func rateButton2Press(row: Int) {
        print(row)
    }
    
    func rateButton3Press(row: Int) {
        print(row)
    }
    
    func rateButton4Press(row: Int) {
        print(row)
    }
    
    func rateButton5Press(row: Int) {
        print(row)
    }
    
    
    func commentButtonPress(row: Int) {
        performSegue(withIdentifier: "CommentsSegue", sender: row)
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "CommentsSegue") {
            let vc = segue.destination as! Comments
            vc.userID = postArray[sender as! Int].user_id
        }
    }
  

    
    func buttonPress(row: Int) {
        
        let blurView = UIView(frame: self.view.frame)
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.navigationController?.view.addSubview(blurView)
        blurView.tag = 853
        ratePopUp.center = blurView.center
        ratePopUp.alpha = 1
        
        blurView.addSubview(ratePopUp)
        
        ratePopUp.translatesAutoresizingMaskIntoConstraints = false
        
        //        ratePopUp.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 64).isActive = true
        //        ratePopUp.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -84).isActive = true
        //        ratePopUp.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 32).isActive = true
        //        ratePopUp.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -32).isActive = true
        ratePopUp.centerXAnchor.constraint(equalTo: blurView.centerXAnchor).isActive = true
        ratePopUp.centerYAnchor.constraint(equalTo: blurView.centerYAnchor).isActive = true
        ratePopUp.heightAnchor.constraint(equalToConstant: 406).isActive = true
        ratePopUp.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
        UIView.transition(with: self.view, duration: 5, options: .showHideTransitionViews, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func linkPress(row: Int) {
        
        //        print("Tap", link.titleLabel?.text!)
        
        print(row)
        
        self.navigationItem.leftBarButtonItems = [closeButton]
        
        let url = URL(string: "https://www.apple.com/iphone/")
        web.load(URLRequest(url: url!))
        web.tag = 74
        self.view.addSubview(web)
        
        let baseUrl = url?.absoluteString
        
        self.navigationItem.title = baseUrl
        navigationItem.titleView = nil
        
    }
    
    
    // comment box
    func commentBox(row: Int) {
        
        print(row)
    }
    
    
    // close pop up
    @IBAction func close(_ sender: UIButton) {
        
        UIView.transition(with: self.view, duration: 5, options: .showHideTransitionViews, animations: {
            self.navigationController?.view.viewWithTag(853)?.removeFromSuperview()
        }, completion: nil)
    }
    
    
    
    func loadHome(completed: @escaping () -> ()) {
        
        let url = baseURL + normal_feeds
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for post in jsonObject! {
                    
                    let postDic = post as? [String: Any]
                    
                    if postDic != nil {
                        
                        let postData = Post()
                        
                        if postDic?["postText"] as? String != nil {
                            
                            if postDic?["post_id"] != nil {
                                postData.post_id = postDic?["post_id"] as! String
                            }
                            
                            if postDic?["website_url"] != nil {
                                postData.website_url = postDic?["website_url"] as! String
                            }
                            
                            if postDic?["description"] != nil {
                                postData.description = postDic?["description"] as! String
                            }
                            
                            if postDic?["user_id"] != nil {
                                postData.user_id = postDic?["user_id"] as! String
                            }
                            
                            if postDic?["username"] != nil {
                                postData.username = postDic?["username"] as! String
                            }
                            
                            if postDic?["postText"] != nil {
                                postData.postText = postDic?["postText"] as! String
                            }
                            
                            if postDic?["postFile"] != nil {
                                postData.postFile = postDic?["postFile"] as! String
                            }
                            
                            if postDic?["qrimage"] != nil {
                                postData.qrimage = postDic?["qrimage"] as! String
                            }
                            
                            if postDic?["post_cat_id"] != nil {
                                postData.post_cat_id = postDic?["post_cat_id"] as! String
                            }
                            
                            if postDic?["view"] != nil {
                                postData.view = postDic?["view"] as! Int
                            } else {
                                postData.view = 0
                                
                            }
                            
                            if postDic?["nitrix_count"] as? String != nil {
                                postData.nitrix_count = postDic?["nitrix_count"] as! String
                            } else {
                                postData.nitrix_count = "0"
                                
                            }
                            
                            if postDic?["comment_count"] != nil {
                                postData.comment_count = postDic?["comment_count"] as! Int
                            } else {
                                postData.comment_count = 0
                                
                            }
                            
                            if postDic?["status"] != nil {
                                postData.status = postDic?["status"] as! String
                            }
                            
                            
                        }
                        
                        self.postArray.append(postData)
                        
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
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postArray.count
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell1") as! HomeCell1
            
            cell.username.text = postArray[indexPath.section].username
            cell.nitrxCount.text = postArray[indexPath.section].nitrix_count
            cell.viewCount.text = String(postArray[indexPath.section].view)
            cell.commentCount.text = String(postArray[indexPath.section].comment_count)

            cell.postFile.loadImageUsingUrlString(urlString: postArray[indexPath.section].postFile)

            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell2") as! HomeCell2
            
            cell.qrImage.loadImageUsingUrlString(urlString: postArray[indexPath.section].qrimage)
            
            cell.postText.text = postArray[indexPath.section].postText
            cell.postLinkButton.setTitle(postArray[indexPath.section].website_url, for: .normal)

            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell3") as! HomeCell3
            
            cell.postDescription.text = postArray[indexPath.section].description

            return cell
            
        } else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell4") as! HomeCell4
            
            cell.commentCount.text = String(postArray[indexPath.section].comment_count)
            cell.commentsDelegate = self
            cell.commentsButton.tag =  indexPath.section

            return cell
            
        } else if indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell5") as! HomeCell5
            cell.delegate = self
            cell.rateDelegate = self

            cell.clickCommentBox.tag = indexPath.section
            
            cell.button1.tag = indexPath.section
            cell.button2.tag = indexPath.section
            cell.button3.tag = indexPath.section
            cell.button4.tag = indexPath.section
            cell.button5.tag = indexPath.section

            return cell
            
        } else if indexPath.row == 5 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell6") as! HomeCell6
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell4") as! HomeCell4
            
            return cell
        }
        
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 16 + 8 + 50 + 8 + 250 + 8 + 30 + 8 + 1 + 3
            
        } else if indexPath.row == 1 {
            
            return UITableView.automaticDimension
            
        } else if indexPath.row == 2 {
            
            return UITableView.automaticDimension

        } else if indexPath.row == 3 {
            
            return 30 + 3 + 3

        } else if indexPath.row == 4 {
            
            return 3 + 30 + 8 + 21 + 8 + 30 + 8

        } else if indexPath.row == 5 {
            
            return 24
            
        } else {
            
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
//    func handleKeyboardNotification(notification: NSNotification) {
//
//        if let userInfo = notification.userInfo {
//
//            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
//            print(keyboardFrame)
//        }
//    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
        }
    }
  
}


class Post {
    
    var post_id = String()
    var website_url = String()
    var description = String()
    var user_id = String()
    var username = String()
    var postText = String()
    var postFile = String()
    var qrimage = String()
    var post_cat_id = String()
    var view = Int()
    var nitrix_count = String()
    var comment_count = Int()
    var status = String()
    
}
