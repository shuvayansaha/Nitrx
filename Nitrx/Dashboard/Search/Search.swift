//
//  Search.swift
//  Nitrx
//
//  Created by Rplanx on 24/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Search: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var catCollectionView: UICollectionView!
    @IBOutlet weak var selectedCatCollectionView: UICollectionView!

    let post_cat_id = UserDefaults.standard.string(forKey: "post_cat_id")
    
    var interestCategory = [SelectInterestClass]()
    var postArray = [PostsClass]()
    var filterPostArray = [PostsClass]()
    var searchBar: UISearchBar!

    var selectedIndex = Int()
    
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
        
        selectInterest {
            self.catCollectionView.reloadData()

            let post_cat_id = self.interestCategory[self.selectedIndex].post_cat_id

            self.loadSearch(post_cat_id: post_cat_id!) {
                
                self.selectedCatCollectionView.reloadData()
            }
        }
        
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
        }
        
        collectionView.reloadData()
    }
    
    // tableview scroll event
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.searchBar.endEditing(true)
    }
    
    // search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            filterPostArray = postArray
            selectedCatCollectionView.reloadData()
            return
        }
        
        filterPostArray = postArray.filter({ (data) -> Bool in
            (data.postText?.lowercased().contains(searchText.lowercased()))!
        })
        
        selectedCatCollectionView.reloadData()
    }
    
    // close keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
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
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([PostsClass].self, from: data)
                
                self.postArray = getData
                self.filterPostArray = getData
                
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
