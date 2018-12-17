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

    @IBOutlet weak var txtView: UIView!
    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    let web = WKWebView()
    
    var closeButton = UIBarButtonItem()
    var imageView = UIImageView()
    var postArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addToolBar(textField: self, txtView: txtView)

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            print(keyboardHeight)
        }
    }
    
    
    // comment send
    @IBAction func sendButton(_ sender: UIButton) {
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
            vc.post_id = postArray[sender as! Int].post_id
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
        
        

        
//        let post_id = postArray[row].post_id
//        let profile_id = postArray[row].profile_id
//
//        print(post_id, profile_id)
//
//        let url = baseURL + save_comment + "?"
//            + "post_id="
//            + "\(post_id)"
//            + "&user_id="
//            + "\(profile_id)"
//            + "&action="
//            + "\("comment_user")"
//            + "&text="
//            + "\("test123")"
//
//        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
//
//            print(stringData)
//
//            do {
//                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
//
//                for json in jsonObject! {
//
//                    if let jsonDic = json as? [String: Any] {
//
//                        if jsonDic["success"] as? Int == 200 {
//
//                            self.performSegue(withIdentifier: "CommentsSegue", sender: row)
//
//                        }
//                    }
//
//                }
//
////                DispatchQueue.main.async { completed() }
//
//            } catch {
//                print("ERROR")
//                DispatchQueue.main.async {
//                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
//                }
//
//            }
//        }

    }
    
    
    // close pop up
    @IBAction func close(_ sender: UIButton) {
        
        UIView.transition(with: self.view, duration: 5, options: .showHideTransitionViews, animations: {
            self.navigationController?.view.viewWithTag(853)?.removeFromSuperview()
        }, completion: nil)
    }
    
    
    
    func loadHome(completed: @escaping () -> ()) {
        
        let url = baseURL + post_details
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
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
                            
                            if postDic?["profile_id"] != nil {
                                postData.profile_id = postDic?["profile_id"] as! String
                            }
                            
                            if postDic?["first_name"] != nil {
                                postData.first_name = postDic?["first_name"] as! String
                            }
                            
                            if postDic?["postText"] != nil {
                                postData.postText = postDic?["postText"] as! String
                            }
                            
                            if postDic?["image"] != nil {
                                postData.image = postDic?["image"] as! String
                            }
                            
                            if postDic?["qrimage"] != nil {
                                postData.qrimage = postDic?["qrimage"] as! String
                            }
                            
                            if postDic?["post_cat_id"] != nil {
                                postData.post_cat_id = postDic?["post_cat_id"] as! String
                            }
                            
                            if postDic?["view_count"] != nil {
                                postData.view_count = postDic?["view_count"] as! Int
                            } else {
                                postData.view_count = 0
                            }
                            
                            if postDic?["ncoins"] as? Int != nil {
                                postData.ncoins = postDic?["ncoins"] as! Int
                            } else {
                                postData.ncoins = 0
                                
                            }
                            
                            if postDic?["comments"] != nil {
                                postData.comments = postDic?["comments"] as! Int
                            } else {
                                postData.comments = 0
                            }
                            
                        
                            
                            
                        }
                        
                        self.postArray.append(postData)
                        
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
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postArray.count
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell1") as! HomeCell1
            
            cell.username.text = postArray[indexPath.section].first_name + postArray[indexPath.section].last_name
            cell.nitrxCount.text = String(postArray[indexPath.section].ncoins)
            cell.viewCount.text = String(postArray[indexPath.section].view_count)
            cell.commentCount.text = String(postArray[indexPath.section].comments)

            cell.postFile.loadImageUsingUrlString(urlString: postArray[indexPath.section].image)

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
            
            cell.commentCount.text = String(postArray[indexPath.section].comments)
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
    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//        }
//    }
  
}


class Post {
    
    var avg_post_rate = Int()
    var comments = Int()
    var description = String()
    var first_name = String()
    var image = String()
    var last_name = String()
    var ncoins = Int()
    var postText = String()
    var post_cat_id = String()
    var post_date = String()
    var post_id = String()
    var profile_id = String()
    var promoted = String()
    var qrimage = String()
    var status = String()
    var user_avatar = String()
    var view_count = Int()
    var website_url = String()

}
