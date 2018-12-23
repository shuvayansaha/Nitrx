//
//  Search.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 17/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Search: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var otherTableView: UITableView!
    @IBOutlet weak var cellCol: UICollectionView!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet var otherView: UIView!
    
    let category = ["Trending", "People", "Food", "Tech", "Film"]
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    var selectedIndex = Int()

    var postArray = [PostsClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getUserData(user_id: user_id!) {
//
//        }
        
//        colView.allowsMultipleSelection = true
//        colView.allowsSelection = true //this is set by default

        
        self.loadSearch(post_cat_id: "2") {
            
            self.cellCol.reloadData()
        }
    

        hideKeyboardWhenTappedAround()

        cellCol.delegate = self
        cellCol.dataSource = self
        
        otherTableView.delegate = self
        otherTableView.dataSource = self
        
        colView.delegate = self
        colView.dataSource = self
        
        // custom search bar on navigation bar
//        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 100, height: 20))
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))

        searchBar.placeholder = "Search..."
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
//        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        // custom navigation bar right side icon
        let notificationBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        notificationBtn.setImage(UIImage(named: "notification"), for: [])
        notificationBtn.addTarget(self, action: #selector(notification), for: UIControl.Event.touchUpInside)
        notificationBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let notificationButton = UIBarButtonItem(customView: notificationBtn)
        
        // custom navigation bar right side icon
        let plusBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        plusBtn.setImage(UIImage(named: "plus"), for: [])
        plusBtn.addTarget(self, action: #selector(notification), for: UIControl.Event.touchUpInside)
        plusBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let plusButton = UIBarButtonItem(customView: plusBtn)
        
        
//        self.navigationItem.rightBarButtonItems = [notificationButton]
//        self.navigationItem.leftBarButtonItems = [plusButton, leftNavBarButton, notificationButton]
        self.navigationItem.leftBarButtonItems = [leftNavBarButton]

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        searchBar.tintColor = .blue
        
//        UITextField.appearance(whenContainedInInstancesOf: [type(of: searchController.searchBar)]).tintColor = .black

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.navigationController?.isNavigationBarHidden = true
    }
    
 
    @objc func notification() {
        print("wallet")
    }
    
    @objc func plus() {
        print("wallet")
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
//        let red = UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1).cgColor
//        let green = UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1).cgColor
//        let gradient = CAGradientLayer()
//        gradient.frame = navView.bounds
//        gradient.colors = [red, green]
//        navView.layer.insertSublayer(gradient, at: 0)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == colView {
            return category.count
        } else {
            return postArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if collectionView == colView {
            
            return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height)
        
        } else {
            
            return CGSize(width: collectionView.frame.size.width/3 - 2, height: collectionView.frame.size.width/3 - 2)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == colView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategoryCell", for: indexPath) as! SearchCategoryCell
            cell.label.text = category[indexPath.row]
            
            if selectedIndex == indexPath.row {
                
                cell.label.textColor = blue
                cell.label.layer.borderColor = blue.cgColor
                cell.label.layer.borderWidth = 1
                cell.label.layer.cornerRadius = 16

            } else {
                
                cell.label.textColor = UIColor.black
                cell.label.layer.borderColor = UIColor.clear.cgColor
                cell.label.layer.borderWidth = 0
                cell.label.layer.cornerRadius = 0
                
            }

            return cell

        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSeacrh", for: indexPath) as! CellSeacrh
            
            cell.image.loadImageUsingUrlString(urlString: postArray[indexPath.row].image!)
            cell.label.text = "  " + postArray[indexPath.row].postText!

            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if collectionView == colView {

            selectedIndex = indexPath.row

//            if indexPath.row == category.count - 1 {
//
//                print("Last")
//
//                self.view.addSubview(otherView)
//                otherView.alpha = 1
//                otherView.dropShadow()
//                otherView.translatesAutoresizingMaskIntoConstraints = false
//
//                otherView.topAnchor.constraint(equalTo: colView.bottomAnchor, constant: 16).isActive = true
////                otherView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
////                otherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//                otherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//                otherView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
//                otherView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
//
//
//            } else {
//                otherView.alpha = 0
//
//            }

            collectionView.reloadData()

        } else {
            
            print(indexPath.row)

            
        }


    }
    
    
    
    
    
    // other tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTableViewCell", for: indexPath) as! OtherTableViewCell
        
        cell.textLabel?.text = category[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    
    //get user data
    func getUserData(user_id: String, completed: @escaping () -> ()) {
        
        let url = baseURL + get_user_data + "?"
            
            + "user_id="
            + "\(user_id)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode(UserDataClass.self, from: data)
                
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    
    
    
    //load search data
    func loadSearch(post_cat_id: String, completed: @escaping () -> ()) {
        
        let url = baseURL + post_details + "?"
            
            + "post_cat_id="
            + "\(post_cat_id)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
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
    
    
}
