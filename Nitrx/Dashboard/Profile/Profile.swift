//
//  Profile.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 17/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Profile: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    let user_id = UserDefaults.standard.string(forKey: "user_id")

    @IBOutlet weak var homeCol: UICollectionView!

    var posts = [PostsClass]()
    var profileDetails: ProfileDetailsClass?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        homeCol.delegate = self
        homeCol.dataSource = self

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
        
          // navigation bar logo centre
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
//        imageView.contentMode = .scaleAspectFit
//        let image = UIImage(named: "logo")
//        imageView.image = image
//        navigationItem.titleView = imageView
        
        if user_id != nil {
            loadProfileDetails(user_id: user_id!) {
                self.homeCol.reloadData()
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

        // Remove all Keys
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        
        // MOVED CONTROLLER
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeNav") as! HomeNav
        //            controller.email = self.email.text!
        //            controller.password = self.password.text!
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 650)
            
//            return UICollectionViewFlowLayout.automaticSize

            
        } else if indexPath.row == 1 {
            return CGSize(width: collectionView.frame.size.width, height: 60)
            
        } else if indexPath.row == 2 {
            // top rated  cell
            
            var totalHeight = CGFloat()
            let eachCellHeight = collectionView.frame.size.width / 3 - 2

            if posts.count > 3 {
                
                let postCount = posts.count / 3
                let rem = posts.count % 3

                if rem == 0 {
                    
                    totalHeight = eachCellHeight * CGFloat(postCount)
                    
                } else {
                    
                    totalHeight = (eachCellHeight * CGFloat(postCount)) + 1
                }
                
            } else {
                
                totalHeight = eachCellHeight
            }
            
            return CGSize(width: collectionView.frame.size.width, height: totalHeight)
            
        }  else {
            return UICollectionViewFlowLayout.automaticSize
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        if indexPath.row == 0 {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileColCell", for: indexPath) as! ProfileColCell
            
            
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
            cell.count3.text = profileDetails?.points
            cell.count4.text = profileDetails?.countUserPosts
            cell.des.text = profileDetails?.about

            return cell
            
        } else if indexPath.row == 1 {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPostHeaderCell", for: indexPath)
            
            return cell

        } else if indexPath.row == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileMyPostCell", for: indexPath) as! ProfileMyPostCell
            
            cell.posts = posts
            cell.colView.reloadData()
            
            return cell
            
        }  else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileMyPostCell", for: indexPath) as! ProfileMyPostCell
            
            return cell
            
        }
        
    }
    
    
    
    
    // load comments
    func loadProfileDetails(user_id: String, completed: @escaping () -> ()) {
        
        let url = baseURL + profile + "?"
            + "user_id=" + "\(user_id)"
            + "&action=" + "\("user_profile")"

        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode(ProfileClass.self, from: data)
                
                for i in getData.posts! {
                    
                    if i.api_status != "400" {
                        
                        self.posts = getData.posts!

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
    }

}
