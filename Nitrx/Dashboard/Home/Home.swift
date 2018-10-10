//
//  Home.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 16/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Home: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CustomCellDelegate {

    @IBOutlet weak var homeCol: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeCol.delegate = self
        homeCol.dataSource = self
        
//        loadHome()

        // custom navigation bar right side icon
        let pencilBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        pencilBtn.setImage(UIImage(named: "notification"), for: [])
        pencilBtn.addTarget(self, action: #selector(notification), for: UIControl.Event.touchUpInside)
        pencilBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let pencilButton = UIBarButtonItem(customView: pencilBtn)
        
        self.navigationItem.rightBarButtonItems = [pencilButton]
        
        // navigation bar logo centre
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
    }

    @objc func notification() {
        print("wallet")
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
        
        return 5
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 1000)

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColCell", for: indexPath) as! HomeColCell
        
        cell.rank.tag = indexPath.row
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
    
    // close pop up
    @IBAction func close(_ sender: UIButton) {
        
        UIView.transition(with: self.view, duration: 5, options: .showHideTransitionViews, animations: {
            self.navigationController?.view.viewWithTag(853)?.removeFromSuperview()
        }, completion: nil)
    }
    
    
    
    func loadHome() {
        
        let url = baseURL + normal_feeds
        let parameters = ["user_id": "40"]
        
        httpPost(controller: self, url: url, headerValue1: "application/json", headerField1: "Content-Type", headerValue2: "application/json", headerField2: "Content-Type", parameters: parameters) { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                let getData = try JSONDecoder().decode(JSONData.self, from: data)
                
                //let data = getData.normal_feeds
                
                print(getData)
                
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    
    
    

}
