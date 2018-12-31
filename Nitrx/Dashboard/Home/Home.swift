//
//  Home.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 16/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import WebKit

class Home: UIViewController, UITableViewDataSource, UITableViewDelegate, CommentCellDelegate, CommentsCellDelegate {
 
    let user_id = UserDefaults.standard.string(forKey: "user_id")

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet var ratePopUp: UIView!
    
    var rateButtonNo = Int()
    var index: Int?

    let web = WKWebView()
    
    var closeButton = UIBarButtonItem()
    var imageView = UIImageView()
    var postArray = [PostsClass]()
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.RoundCornerButtonWithGrayBorder()
        button2.RoundCornerButtonWithGrayBorder()
        button3.RoundCornerButtonWithGrayBorder()
        button4.RoundCornerButtonWithGrayBorder()
        button5.RoundCornerButtonWithGrayBorder()
        
        addPullToRefreshTableView()

//        hideKeyboardWhenTappedAround()
        
        homeTable.delegate = self
        homeTable.dataSource = self

        loadHome {
            self.homeTable.reloadData()
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
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeybaordNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeybaordNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
//        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
        commentTextField.endEditing(true)
    }

    deinit {

        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)

    }


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // navigation bar gradient color
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }
    
    // pull to refresh
    func addPullToRefreshTableView() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        homeTable.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: Any) {
        //  your code to refresh tableView
        
        loadHome {
            self.refreshControl.endRefreshing()
            self.homeTable.reloadData()

        }
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
    


    

    // comment view
    @IBAction func rateButtonAction(_ sender: UIButton) {
    
        rateButtonNo = sender.tag
        
        if sender.tag == 1 {
            
            button1.setImage(UIImage(named: "avater1-white"), for: .normal)
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if sender.tag == 2 {
            
            button1.setImage(UIImage(named: "avater1"), for: .normal)
            button2.setImage(UIImage(named: "avater2-white"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if sender.tag == 3 {
            
            button1.setImage(UIImage(named: "avater1"), for: .normal)
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car-white"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if sender.tag == 4 {
            
            button1.setImage(UIImage(named: "avater1"), for: .normal)
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster-white"), for: .normal)
            button5.setImage(UIImage(named: "avater3"), for: .normal)
            
        } else if sender.tag == 5 {
            
            button1.setImage(UIImage(named: "avater1"), for: .normal)
            button2.setImage(UIImage(named: "avater2"), for: .normal)
            button3.setImage(UIImage(named: "car"), for: .normal)
            button4.setImage(UIImage(named: "booster"), for: .normal)
            button5.setImage(UIImage(named: "avater3-white"), for: .normal)
            
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
    
    
    
    // link press
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
    
    // close pop up
    @IBAction func close(_ sender: UIButton) {
        
        UIView.transition(with: self.view, duration: 5, options: .showHideTransitionViews, animations: {
            self.navigationController?.view.viewWithTag(853)?.removeFromSuperview()
        }, completion: nil)
    }
    
    
    

    
    func commentPress(row: Int) {
        print(row)
        
        index = row
        rateButtonNo = 0
        
        button1.setImage(UIImage(named: "avater1"), for: .normal)
        button2.setImage(UIImage(named: "avater2"), for: .normal)
        button3.setImage(UIImage(named: "car"), for: .normal)
        button4.setImage(UIImage(named: "booster"), for: .normal)
        button5.setImage(UIImage(named: "avater3"), for: .normal)

        commentTextField.becomeFirstResponder()

        
    }
    

    
 
    @IBAction func postCommentButtonAction(_ sender: UIButton) {

        self.postComment()
        
    }
 

    
    
    // all comments view
    func commentButtonPress(row: Int) {
        performSegue(withIdentifier: "CommentsSegue", sender: row)
        
        index = row

    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "CommentsSegue") {
            let vc = segue.destination as! Comments
            vc.post_id = postArray[sender as! Int].post_id!
            vc.profile_id = user_id!
            
        }
    }

    
    
    // MARK : -  TABLE VIEW

    func numberOfSections(in tableView: UITableView) -> Int {
        return postArray.count
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell1") as! HomeCell1
            
            cell.username.text = postArray[indexPath.section].first_name! + " " + postArray[indexPath.section].last_name!
//            cell.nitrxCount.text = "\((postArray[indexPath.section].ncoins)!)"
            cell.viewCount.text = "\((postArray[indexPath.section].view_count)!)"
            cell.commentCount.text = "\((postArray[indexPath.section].comments)!)"
            cell.postedDate.text = postArray[indexPath.section].post_date

            cell.postFile.loadImageUsingUrlString(urlString: postArray[indexPath.section].image!)
            
            cell.userImage.loadImageUsingUrlString(urlString: postArray[indexPath.section].user_avatar!)
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell2") as! HomeCell2
            
            cell.qrImage.loadImageUsingUrlString(urlString: postArray[indexPath.section].qrimage!)
            
            cell.postText.text = postArray[indexPath.section].postText
            cell.postLinkButton.setTitle(postArray[indexPath.section].website_url, for: .normal)

            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell3") as! HomeCell3
            
            cell.postDescription.text = postArray[indexPath.section].description

            return cell
            
        } else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell4") as! HomeCell4
            
            cell.commentCount.text = "\((postArray[indexPath.section].comments)!)"
            cell.commentsDelegate = self
            cell.commentsButton.tag = indexPath.section

            let avg_post_rate = postArray[indexPath.section].avg_post_rate
            
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
            
        } else if indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell5") as! HomeCell5

            let avg_post_rate = postArray[indexPath.section].avg_post_rate
            
            if avg_post_rate == 1 {
                cell.button1.setImage(UIImage(named: "avater1-white"), for: .normal)
            } else if avg_post_rate == 2 {
                cell.button2.setImage(UIImage(named: "avater2-white"), for: .normal)
            } else if avg_post_rate == 3 {
                cell.button3.setImage(UIImage(named: "car-white"), for: .normal)
            } else if avg_post_rate == 4 {
                cell.button4.setImage(UIImage(named: "booster-white"), for: .normal)
            } else if avg_post_rate == 5 {
                cell.button5.setImage(UIImage(named: "avater3-white"), for: .normal)
            } else {
                cell.button1.setImage(UIImage(named: "avater1"), for: .normal)
                cell.button2.setImage(UIImage(named: "avater2"), for: .normal)
                cell.button3.setImage(UIImage(named: "car"), for: .normal)
                cell.button4.setImage(UIImage(named: "booster"), for: .normal)
                cell.button5.setImage(UIImage(named: "avater3"), for: .normal)

            }
            
            cell.commentButton.tag = indexPath.section
            cell.delegate = self

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
    
  
    
    
    func postComment() {
        
        let post_id = postArray[index!].post_id
        
        let url = baseURL + save_comment + "?"
            + "post_id="
            + "\(post_id!)"
            + "&user_id="
            + "\(user_id!)"
            + "&action="
            + "\("comment_user")"
            + "&text="
            + "\((commentTextField.text)!)"
            + "&rate_post="
            + "\(rateButtonNo)"
        
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            //            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([SendCommentsClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
                        self.commentTextField.text = ""
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
//                DispatchQueue.main.async {
//                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
//                }
                snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")

            }
        }
        
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
    
    

    // get user data
//    func getUserData(user_id: String, completed: @escaping () -> ()) {
//
//        let url = baseURL + get_user_data + "?"
//
//            + "user_id="
//            + "\(user_id)"
//
//        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
//
//            print(stringData)
//
//            do {
//
//                let getData = try JSONDecoder().decode(UserDataClass.self, from: data)
//
//                DispatchQueue.main.async { completed() }
//
//            } catch {
//                print("ERROR")
//                DispatchQueue.main.async {
//                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
//                }
//            }
//        }
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeybaordNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeybaordNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        bottomConstraint.constant = -90
        
    }
    
    
    // tableview scroll event
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        view.endEditing(true)
        bottomConstraint.constant = -90

    }
    
    
    @objc func handleKeybaordNotification(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomConstraint?.constant = keyboardHeight
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyboardShowing ? keyboardHeight : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                if isKeyboardShowing {
                    
                    if self.index != 0 {
                        let indexPath = IndexPath(row: 3, section: self.index!)
                        self.homeTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
            }
        }
    }
  
}



