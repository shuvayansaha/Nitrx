//
//  Profile.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 05/01/19.
//  Copyright © 2019 Nitrx. All rights reserved.
//

import UIKit

class Profile: UIViewController, PostDelEditDelegate {

    @IBOutlet weak var profileCollection: UICollectionView!
    
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    var posts = [PostsClass]()
    var profileDetails: ProfileDetailsClass?
    var othersUserId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        profileCollection.delegate = self
        profileCollection.dataSource = self
        
        let searchBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        searchBtn.setImage(UIImage(named: "wallet-white"), for: [])
        searchBtn.addTarget(self, action: #selector(searchBtnPressed), for: UIControl.Event.touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchButton = UIBarButtonItem(customView: searchBtn)
        
        let clipBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        clipBtn.setImage(UIImage(named: "settings-white"), for: [])
        clipBtn.addTarget(self, action: #selector(searchBtnPressed), for: UIControl.Event.touchUpInside)
        clipBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let clipButton = UIBarButtonItem(customView: clipBtn)
        
        self.navigationItem.rightBarButtonItems = [clipButton, searchButton]
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if othersUserId == "" {
            
            if user_id != nil {
                loadProfileDetails(user_id: user_id!) {
                    self.profileCollection.reloadData()
                }
            }
        } else {
            
            title = "Profile"
            
            loadProfileDetails(user_id: othersUserId) {
                self.profileCollection.reloadData()
            }
        }
      
    }
    
    
    @objc func wallet() {
        print("wallet")
    }
    
    @objc func notification() {
        print("wallet")
    }
    
    @objc func searchBtnPressed() {
        print("logout")
        
        //        UserDefaults.standard.removeObject(forKey: "Key")
//
//        // Remove all Keys
//        if let appDomain = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: appDomain)
//        }
        
//        // MOVED CONTROLLER
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "HomeNav") as! HomeNav
//        //            controller.email = self.email.text!
//        //            controller.password = self.password.text!
//
//        self.present(controller, animated: true, completion: nil)
        
        
        // MOVE CONTROLLER
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeNav") as! HomeNav
        self.present(controller, animated: true, completion: nil)
        UserDefaults.standard.set(nil, forKey: "token")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }
    
   
    // load comments
    func loadProfileDetails(user_id: String, completed: @escaping () -> ()) {
        
        let url = baseURL + profile + "?"
            + "user_id=" + "\(user_id)"
            + "&action=" + "\("user_profile")"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode(ProfileClass.self, from: data)
                
                for i in getData.posts! {
                    
                    if i.api_status != "400" {
                        
                        self.posts = getData.posts!
                        
                    } else {
                        self.posts = [PostsClass]()
                    }
                }
                
                self.profileDetails = getData.profile
                
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        if (segue.identifier == "EditProfile") {
            let vc = segue.destination as! EditProfile
            
            vc.getProfileImage = profileDetails?.image_path
            vc.getName = profileDetails?.first_name
            vc.getUsername = profileDetails?.username
            vc.getAbout = profileDetails?.about
            
        }
        
        
        if segue.identifier == "profilePost" {
            if let vc = segue.destination as? Home2 {
                vc.postCatId = sender as! String
            }
        }
        
        if segue.identifier == "editPost" {
            if let vc = segue.destination as? CreatePost {
                vc.id = sender as! String
            }
        }
    }
    
    
}









extension Profile: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return posts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileDetailsCell", for: indexPath) as! ProfileDetailsCell
            
            if let img = profileDetails?.image_path {
                cell.userImage.imageLoadingUsingUrlString(urlString: img)
            }
            
            if let qrImg = profileDetails?.qrimage {
                cell.qrImage.imageLoadingUsingUrlString(urlString: qrImg)
            }
            
            if let first_name = profileDetails?.first_name {
                
                if let last_name = profileDetails?.last_name {
                    
                    cell.username.text = first_name + " " + last_name
                    
                }
                
            }
            
            cell.count1.text = profileDetails?.countFollowing
            cell.count2.text = profileDetails?.countFollowers
            cell.count3.text = profileDetails?.countUserPosts
            //            cell.count4.text = profileDetails?.countUserPosts
            cell.des.text = profileDetails?.about
            
            if let score = profileDetails?.user_score {
                
                cell.score.text = String(score)
                
                switch score {
                case 0 ... 100:
                    cell.score.textColor = UIColor.red
                    cell.scoreImage.image = UIImage(named: "1")
                case 101 ... 200:
                    cell.score.textColor = UIColor.red
                    cell.scoreImage.image = UIImage(named: "2")
                    
                case 201 ... 300:
                    cell.score.textColor = UIColor.brown
                    cell.scoreImage.image = UIImage(named: "3")
                    
                case 301 ... 400:
                    cell.score.textColor = UIColor.green
                    cell.scoreImage.image = UIImage(named: "4")
                    
                case 401 ... 500:
                    cell.score.textColor = UIColor.green
                    cell.scoreImage.image = UIImage(named: "5")
                    
                default:
                    cell.score.textColor = UIColor.red
                    
                }
            }
            
            if othersUserId != "" {
                
                if let follow = profileDetails?.follow_privacy {
                    
                    cell.edit.setTitle("Follow", for: .normal)

                } else {
                    
                    cell.edit.setTitle("Following", for: .normal)

                }
            }
            
            cell.edit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapEditProfile)))
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostHeaderCell", for: indexPath) as! PostHeaderCell
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePostCell", for: indexPath) as! ProfilePostCell
            
            if let img = posts[indexPath.row].image {
                cell.image.imageLoadingUsingUrlString(urlString: img)
            }
            
            if let postText = posts[indexPath.row].postText {
                cell.label.text = "  " + postText
            }
            
            cell.postDelEditDel = self
            cell.editPostButton.tag = indexPath.row
            cell.deletePostButton.tag = indexPath.row
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            
            return CGSize(width: view.frame.width , height: 571)

//            return UICollectionViewFlowLayout.automaticSize
            
        } else if indexPath.section == 1 {
            
            return CGSize(width: view.frame.width , height: 60)
            
        } else {
            
            return CGSize(width: view.frame.width / 3 - 2, height: view.frame.width / 3 - 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            if indexPath.section == 2 {
            
            let data = posts[indexPath.row].post_cat_id
            
            performSegue(withIdentifier: "profilePost", sender: data)
            
        }
        
    }
    
  
    @objc func tapEditProfile() {
        
        if othersUserId == "" {
            
            performSegue(withIdentifier: "EditProfile", sender: nil)
            
        } else {
            
            print("call follow service")
            
            followUnfollowFunc {
                
                
            }
        }
    }
    
    
    func postEdit(row: Int) {
        
        if let post_id = posts[row].post_id {
            performSegue(withIdentifier: "editPost", sender: post_id)

        }
        
    }
    
    func postDel(row: Int) {
        let post_id = posts[row].post_id
        
        presentAlertWithActionCancel(title: "Delete Post", message: "Want to delete this post", buttonText: "Delete") {
            
            self.deletePostFunc(postID: post_id!, completed: {
                
                self.loadProfileDetails(user_id: self.user_id!) {
                    self.profileCollection.reloadData()
                }
            })
        }
        
    }

    // load comments
    func deletePostFunc(postID: String, completed: @escaping () -> ()) {
        
        let url = baseURL + delete_post + "?"
            + "post_id=" + "\(postID)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([EditProfileClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
                        snackBarFunction(message: i.success!)
                    }
                    
                    if let err = i.errors?.error_text {
                        
                        snackBarFunction(message: err)
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
    
    
    // follow and unfollow function
    func followUnfollowFunc(completed: @escaping () -> ()) {
        
        let url = baseURL + following_action + "?"
            + "user_id=" + "\(user_id!)"
            + "&following_id=" + "\(othersUserId)"
            + "&f=" + "\("follow_user")"

        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([EditProfileClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
//                        snackBarFunction(message: i.success!)
                    }
                    
                    if let err = i.errors?.error_text {
                        
                        snackBarFunction(message: err)
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
