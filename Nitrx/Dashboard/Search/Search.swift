//
//  Search.swift
//  Nitrx
//
//  Created by Rplanx on 24/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Search: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, SearchRateDelegate {

    @IBOutlet weak var catCollectionView: UICollectionView!
    @IBOutlet weak var selectedCatCollectionView: UICollectionView!
    @IBOutlet var userSearchTable: UIView!
    @IBOutlet weak var searchUserTableView: UITableView!
    
    @IBOutlet var ratePopUp: UIView!
    var blurView = UIView()
    var searchBar: UISearchBar!

    let post_cat_id = UserDefaults.standard.string(forKey: "post_cat_id")
    let user_id = UserDefaults.standard.string(forKey: "user_id")

    var interestCategory = [SelectInterestClass]()
    var postArray = [PostsClass]()
    var filterPostArray = [PostsClass]()
    
    var userArray = [PostsClass]()
    var filterUserArray = [PostsClass]()
    
    var selectedIndex = Int()
    var postRate = Int()
    var indexRow = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        hideKeyboardWhenTappedAround()

        // custom search bar on navigation bar
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        
        searchBar.placeholder = "Search..."
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        
        self.navigationItem.leftBarButtonItems = [leftNavBarButton]
        searchBar.tintColor = .blue
        searchBar.delegate = self

        catCollectionView.delegate = self
        catCollectionView.dataSource = self
        selectedCatCollectionView.delegate = self
        selectedCatCollectionView.dataSource = self
        
        searchUserTableView.delegate = self
        searchUserTableView.dataSource = self
        
        selectInterest {
            self.catCollectionView.reloadData()

            let post_cat_id = self.interestCategory[self.selectedIndex].post_cat_id

            self.loadSearch(post_cat_id: post_cat_id!) {
                
                self.selectedCatCollectionView.reloadData()
            }
        }
        
//        blurView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBlurView)))
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == catCollectionView {
            return interestCategory.count
        } else {
            return filterPostArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == catCollectionView {
            return CGSize(width: collectionView.frame.size.width/3 - 8, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: collectionView.frame.size.width/3 - 2, height: collectionView.frame.size.width/3 - 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == catCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCatCell", for: indexPath) as! SearchCatCell
            
            cell.label.text = interestCategory[indexPath.row].post_cat_name
            
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
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCatCell", for: indexPath) as! SearchPostCatCell
            
            if let img = filterPostArray[indexPath.row].image {
                
                cell.image.imageLoadingUsingUrlString(urlString: img)
            }
            
            if let txt = filterPostArray[indexPath.row].postText {
                
                cell.label.text = "  " + txt
            }
            
            cell.rateDelegate = self
            cell.rate.tag = indexPath.row
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == catCollectionView {
//            print(interestCategory[indexPath.row])
            
            selectedIndex = indexPath.row
            let post_cat_id = interestCategory[selectedIndex].post_cat_id
            
            loadSearch(post_cat_id: post_cat_id!) {
                self.selectedCatCollectionView.reloadData()
            }
            
        } else {
//            print(filterPostArray[indexPath.row])
            
            if let postCatId = filterPostArray[indexPath.row].post_cat_id {
                
                performSegue(withIdentifier: "SearchDetails", sender: postCatId)

            }
            
        }
        
        collectionView.reloadData()
    }
    
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "SearchDetails") {
            let vc = segue.destination as! Home2
            vc.postCatId = sender as! String

        }
    }
    
    
    // tableview scroll event
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.searchBar.endEditing(true)
    }
    
    // search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.range(of: "@") == nil {
           
            closeTableUIView()

            guard !searchText.isEmpty else {
                filterPostArray = postArray
                selectedCatCollectionView.reloadData()
                return
            }
            
            filterPostArray = postArray.filter({ (data) -> Bool in
                (data.postText?.lowercased().contains(searchText.lowercased()))!
            })
            
            selectedCatCollectionView.reloadData()
            
        } else {
            
            tableUIView()
            
            loadUserSearch(param: searchText) {
                
                guard !searchText.isEmpty else {
                    self.filterUserArray = self.userArray
                    self.searchUserTableView.reloadData()
                    return
                }

                self.filterUserArray = self.userArray.filter({ (data) -> Bool in
                    (data.first_name?.lowercased().contains(searchText.lowercased()))!
                })
                
                self.searchUserTableView.reloadData()
            }
            

        }
        
   
    }
    
    // close keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func rate(row: Int) {

        indexRow = row
 
        // MARK : - blur popup view

        blurView.frame = self.view.frame
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
    
    // close pop up
    @IBAction func closeRatePopUp(_ sender: UIButton) {

        closeUiView()
        postRate = Int()
        indexRow = Int()
    }
    
    func closeUiView() {
        
        UIView.transition(with: self.view, duration: 0.3, options: .showHideTransitionViews, animations: {
            self.navigationController?.view.viewWithTag(853)?.removeFromSuperview()
        }, completion: nil)
    }
    
    @IBAction func rateButton(_ sender: UIButton) {
        
        postRate = sender.tag
        
        if let postId = filterPostArray[indexRow].post_id {
            
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
    
    
//    @objc func tapBlurView() {
//
//
//        print("close uiview")
//        UIView.transition(with: self.view, duration: 5, options: .showHideTransitionViews, animations: {
//            self.navigationController?.view.viewWithTag(853)?.removeFromSuperview()
//        }, completion: nil)
//
//    }

    

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
            
//            print(stringData)
            
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
    
    
    //get user data
    func selectInterest(completed: @escaping () -> ()) {
        
        let url = baseURL + select_interest + "?"
            
            + "post_cat_id="
            + "\(post_cat_id!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([SelectInterestClass].self, from: data)
                
                self.interestCategory = getData
                
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
            + "&user_id="
            + "\(user_id!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([PostsClass].self, from: data)
                
                for i in getData {
                    
                    if i.api_status != "400" {
                        
                        self.postArray = getData
                        self.filterPostArray = getData
                        
                    } else {
                        
                        self.postArray = [PostsClass]()
                        self.filterPostArray = [PostsClass]()
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
    
    
    func tableUIView() {
        
        view.addSubview(userSearchTable)
        
        userSearchTable.translatesAutoresizingMaskIntoConstraints = false
        
        userSearchTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        userSearchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        userSearchTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        userSearchTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func closeTableUIView() {
        
        UIView.transition(with: self.view, duration: 0.1, options: .showHideTransitionViews, animations: {
            self.userSearchTable.removeFromSuperview()
        }, completion: nil)
    }
    
}


extension Search: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterUserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchUser", for: indexPath) as! SearchUser
        
        cell.textLabel?.text = filterUserArray[indexPath.row].last_name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    
    
    //load search data
    func loadUserSearch(param: String, completed: @escaping () -> ()) {
        
        let url = baseURL + post_details + "?"
            
            + "param="
            + "\(param)"
            + "&user_id="
            + "\(user_id!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([PostsClass].self, from: data)
                
                for i in getData {
                    
                    if i.api_status != "400" {
                        
                        self.filterUserArray = getData
                        self.userArray = getData
                        
                    } else {
                        
                        self.postArray = [PostsClass]()
                        self.filterPostArray = [PostsClass]()
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
