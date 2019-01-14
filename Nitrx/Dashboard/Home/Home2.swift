//
//  Home2.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 31/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import WebKit

class Home2: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDel, RateDel, ShowComments, OpenWebView, PostRateFollowDelegate {
  
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var notiButton: UIBarButtonItem!
    @IBOutlet var ratePopUp: UIView!
    var blurView = UIView()

    let user_id = UserDefaults.standard.string(forKey: "user_id")
    let imagePath = UserDefaults.standard.string(forKey: "Image-Path")
    var postCatId = String()

    var postArray = [PostsClass]()
   
    var imageView = UIImageView()
    var web = WKWebView()
    var closeButton = UIBarButtonItem()
    var indexRow = IndexPath()
    var postRate = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self

      
        
//        // custom navigation bar right side icon
//        let pencilBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
//        pencilBtn.setImage(UIImage(named: "notification"), for: [])
//        pencilBtn.addTarget(self, action: #selector(notification), for: UIControl.Event.touchUpInside)
//        pencilBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let pencilButton = UIBarButtonItem(customView: pencilBtn)
//
        // custom navigation bar right side icon
        let closeWeb: UIButton = UIButton(type: UIButton.ButtonType.custom)
        closeWeb.setImage(UIImage(named: "cross-white"), for: [])
        closeWeb.addTarget(self, action: #selector(closeWebFunc), for: UIControl.Event.touchUpInside)
        closeWeb.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        closeButton = UIBarButtonItem(customView: closeWeb)

//        self.navigationItem.rightBarButtonItems = [pencilButton]
        
        // navigation bar logo centre
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.isTranslucent = false
        
//        notiButton.addBadge(number: 8, withOffset: CGPoint(x: 5.0, y: 5.0), andColor: UIColor.red, andFilled: true)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // navigation bar gradient color
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }

   
    @IBAction func notification(_ sender: UIBarButtonItem) {
        
    }
    
    func ratePostFunction(indexPath: IndexPath) {
        
        indexRow = indexPath
        
        // MARK : - blur popup view
        
        blurView.frame = self.view.frame
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.navigationController?.view.addSubview(blurView)
        blurView.tag = 854
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
    
    // close pop up
    @IBAction func closeRatePopUp(_ sender: UIButton) {
        
        closeUiView()
        postRate = Int()
        indexRow = IndexPath()
    }
    
    func closeUiView() {
        
        UIView.transition(with: self.view, duration: 0.3, options: .showHideTransitionViews, animations: {
            self.navigationController?.view.viewWithTag(854)?.removeFromSuperview()
        }, completion: nil)
    }
    
    @IBAction func postRateButton(_ sender: UIButton) {
        
        postRate = sender.tag
        
        if let postId = postArray[indexRow.row].post_id {
            
            //            print(postId, postRate)
            
            self.closeUiView()
            
            ratePostFunc(postRate: String(postRate), postId: postId) {
                
                self.presentAlertWithAction(title: "Success", message: "Successfully rated this post", buttonText: "Done", completion: {
                    
                    //                let post_cat_id = self.interestCategory[self.selectedIndex].post_cat_id
                    //
                    //                self.loadSearch(post_cat_id: post_cat_id!) {
                    //
                    //                    self.selectedCatCollectionView.reloadData()
                    //                }
                })
                
                
            }
            
        }
    }
    
    //rate post
    func ratePostFunc(postRate: String, postId: String, completed: @escaping () -> ()) {
        
        let url = baseURL + post_coins + "?"
            
            + "post_id="
            + "\(postId)"
            + "&coins_value="
            + "\(postRate)"
            + "&user_id="
            + "\(user_id!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([SelectInterestClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
                        
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
    
    
    
    func followPostFunction(indexPath: IndexPath) {

        if let profileId = postArray[indexPath.row].profile_id {
            
            followPostFunc(userId: profileId, followId: profileId) {

            }
        }
    }
    
    
    //rate post
    func followPostFunc(userId: String, followId: String, completed: @escaping () -> ()) {
        
        let url = baseURL + following_action + "?"
            
            + "user_id="
            + "\(userId)"
            + "&following_no="
            + "\(followId)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([SelectInterestClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
                        
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
    
    
    
    func commentTextFunction(indexPath: IndexPath) {
        
        view.endEditing(true)
        
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
                        self.performSegue(withIdentifier: "CommentsSegue", sender: indexPath.row)
                        
                    } else {
                        
                        if let err = i.errors?.error_text {
                            snackBarFunction(message: err)
                        }
                    }
                }
                
                //                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
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
    
    func showCommentsFunction(indexPath: IndexPath) {
    
        performSegue(withIdentifier: "CommentsSegue", sender: indexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "CommentsSegue") {
            let vc = segue.destination as! Comments
            vc.post_id = postArray[sender as! Int].post_id!
            vc.profile_id = user_id!
        }
    }
    
    func webViewFunction(indexPath: IndexPath) {
        
        let urlLink = postArray[indexPath.row].website_url!
        
        self.navigationItem.leftBarButtonItems = [closeButton]

        web = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(web)

        let url = URL(string: "http://" + urlLink)
        web.load(URLRequest(url: url!))
        web.tag = 74

//        let baseUrl = url?.absoluteString
        self.navigationItem.title = urlLink
        navigationItem.titleView = nil
        
//        print(url!)
    }
    
    @objc func closeWebFunc() {
        
        if let viewWithTag = self.view.viewWithTag(74) {
            viewWithTag.removeFromSuperview()
            self.navigationItem.leftBarButtonItems = nil
            navigationItem.titleView = imageView
            
        } else{
            print("No!")
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
        cell.showCommentsDelegate = self
        cell.openWebViewDelegate = self
        cell.rateFollowDelegate = self

        cell.indexPath = indexPath
        
        cell.postedDate.text = postArray[indexPath.row].post_date
        
        if let firstName = postArray[indexPath.row].first_name {
            
            if let lastName = postArray[indexPath.row].last_name {
                
                cell.username.text = firstName + " " + lastName
            }
        }
        
        if let postImage = postArray[indexPath.row].image {
            cell.postImage.imageLoadingUsingUrlString(urlString: postImage)
        }
        
        if let userAvatar = postArray[indexPath.row].user_avatar {
            cell.userImage.imageLoadingUsingUrlString(urlString: userAvatar)
        }
        
        if let viewCount = postArray[indexPath.row].view_count {
            cell.viewCount.text = "\(viewCount)"
        }
        
        if let ncoinsCount = postArray[indexPath.row].ncoins {
            cell.nitrxCount.text = "\(ncoinsCount)"
        }
        
        if let qrImage = postArray[indexPath.row].qrimage {
            cell.qrImage.imageLoadingUsingUrlString(urlString: qrImage)
        }
        
        cell.postText.text = postArray[indexPath.row].postText
        
        if let webUrl = postArray[indexPath.row].website_url {
            
            cell.postLinkButton.setTitle("  " + "\(webUrl)", for: .normal)
        }
        
        cell.postDescription.text = postArray[indexPath.row].description
        
        if let img = imagePath {
            cell.userImageInComment.imageLoadingUsingUrlString(urlString: img)
        }
        
        if postArray[indexPath.row].post_following == 1 {
            cell.followButton.setTitle("Following", for: .normal)
        } else {
            cell.followButton.setTitle("Follow", for: .normal)
        }
        
        if let commentCount = postArray[indexPath.row].comments {
            
            cell.commentCount.text = "\(commentCount)"
            cell.commentsCount.text = "\(commentCount)"
            
            if commentCount > 0 {
                
                cell.commentsCount.alpha = 1
                cell.commentsButton.alpha = 1
                
                if let avg_post_rate = postArray[indexPath.row].avg_post_rate {
                    
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
                    }
                    
                }
                
                if let rate = postArray[indexPath.row].login_user_rating {
                    
                    if rate != "NA" {
                        
                        cell.rate1.isEnabled = false
                        cell.rate2.isEnabled = false
                        cell.rate3.isEnabled = false
                        cell.rate4.isEnabled = false
                        cell.rate5.isEnabled = false
                        
                        if rate == "1" {
                            
                            cell.rate1.setImage(UIImage(named: "avater1-white"), for: .normal)
                            cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
                            cell.rate3.setImage(UIImage(named: "car"), for: .normal)
                            cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
                            cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
                            
                        } else if rate == "2" {
                            
                            cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
                            cell.rate2.setImage(UIImage(named: "avater2-white"), for: .normal)
                            cell.rate3.setImage(UIImage(named: "car"), for: .normal)
                            cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
                            cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
                            
                        } else if rate == "3" {
                            
                            cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
                            cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
                            cell.rate3.setImage(UIImage(named: "car-white"), for: .normal)
                            cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
                            cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
                            
                        } else if rate == "4" {
                            
                            cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
                            cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
                            cell.rate3.setImage(UIImage(named: "car"), for: .normal)
                            cell.rate4.setImage(UIImage(named: "booster-white"), for: .normal)
                            cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
                            
                        } else if rate == "5" {
                            
                            cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
                            cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
                            cell.rate3.setImage(UIImage(named: "car"), for: .normal)
                            cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
                            cell.rate5.setImage(UIImage(named: "avater3-white"), for: .normal)
                            
                        }
                        
                    } else {
                        
                        cell.rate1.isEnabled = true
                        cell.rate2.isEnabled = true
                        cell.rate3.isEnabled = true
                        cell.rate4.isEnabled = true
                        cell.rate5.isEnabled = true
                        
                        cell.rate1.setImage(UIImage(named: "avater1"), for: .normal)
                        cell.rate2.setImage(UIImage(named: "avater2"), for: .normal)
                        cell.rate3.setImage(UIImage(named: "car"), for: .normal)
                        cell.rate4.setImage(UIImage(named: "booster"), for: .normal)
                        cell.rate5.setImage(UIImage(named: "avater3"), for: .normal)
                        
                    }
                }
                
            } else {
                
                cell.commentsCount.alpha = 0
                cell.commentsButton.alpha = 0
                cell.avarageRate.image = nil
                
            }
        }
      
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }

    // tableview scroll event
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        view.endEditing(true)
    }
    
    
    
    //load home data
    func loadHome(completed: @escaping () -> ()) {
        
        var url = String()
        
        if postCatId != "" {
            url = baseURL + post_details + "?post_cat_id=\(postCatId)"
                + "&user_id="
                + "\(user_id!)"

        } else {
            url = baseURL + post_details
                + "?user_id="
                + "\(user_id!)"
        }
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([PostsClass].self, from: data)
                
                self.postArray = getData
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")

            }
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadHome {
            self.homeTableView.reloadData()
        }
        
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





extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

private var handle: UInt8 = 0

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(7)
        let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - 4, y: offset.y), size: CGSize(width: 8, height: 16))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}
