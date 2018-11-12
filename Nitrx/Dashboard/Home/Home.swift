//
//  Home.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 16/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import WebKit

class Home: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CustomCellDelegate {

    @IBOutlet weak var homeCol: UICollectionView!
    
    let web = WKWebView()
    
    var closeButton = UIBarButtonItem()
    var imageView = UIImageView()
    var postArray = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        homeCol.delegate = self
        homeCol.dataSource = self
        
        
        loadHome {
            self.homeCol.reloadData()

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
    
    @IBOutlet var ratePopUp: UIView!
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return postArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 1000)

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColCell", for: indexPath) as! HomeColCell
        
        cell.rank.tag = indexPath.row
        cell.link.tag = indexPath.row
        
        cell.postText.text = postArray[indexPath.row].postText

        cell.delegate = self
        
        return cell
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
        ratePopUp.heightAnchor.constraint(equalToConstant: 420).isActive = true
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
    
    
    // close pop up
    @IBAction func close(_ sender: UIButton) {
        
        UIView.transition(with: self.view, duration: 5, options: .showHideTransitionViews, animations: {
            self.navigationController?.view.viewWithTag(853)?.removeFromSuperview()
        }, completion: nil)
    }
    
    
    
    func loadHome(completed: @escaping () -> ()) {
        
        let url = baseURL + normal_feeds
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
        
//            print(stringData)
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for post in jsonObject! {
                    
                    let postDic = post as? [String: Any]
                    
                    if postDic != nil {
                        
                        let postData = Post()
                        
                        if postDic?["postText"] as? String != nil {
                            
                            postData.postText = postDic?["postText"] as! String

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
    
    
    
    

}


class Post {
    

    var postText = String()


}
