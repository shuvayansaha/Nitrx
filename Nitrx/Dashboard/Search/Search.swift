//
//  Search.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 17/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Search: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var otherTableView: UITableView!
    @IBOutlet weak var cellCol: UICollectionView!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet var otherView: UIView!
    
    let category = ["Trending", "People", "Food", "Tech", "Film", "Other"]
   
    override func viewDidLoad() {
        super.viewDidLoad()


        cellCol.delegate = self
        cellCol.dataSource = self
        
        otherTableView.delegate = self
        otherTableView.dataSource = self
        
        colView.delegate = self
        colView.dataSource = self
        
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))

        searchBar.placeholder = "Saerch"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.navigationController?.isNavigationBarHidden = true
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
    
    var selectedIndex = Int()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == colView {
            return category.count
        } else {
            return 5
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if collectionView == colView {
            
            return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height)
        
        } else {
            
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width + collectionView.frame.size.width/3)

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
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == colView {
            selectedIndex = indexPath.row
            
            if indexPath.row == category.count - 1 {
                
                print("Last")
                
                self.view.addSubview(otherView)
                otherView.alpha = 1
                otherView.dropShadow()
                otherView.translatesAutoresizingMaskIntoConstraints = false
                
                otherView.topAnchor.constraint(equalTo: colView.bottomAnchor, constant: 16).isActive = true
//                otherView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
//                otherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
                otherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
                otherView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
                otherView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true

                
            } else {
                otherView.alpha = 0

            }
            
            collectionView.reloadData()

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
    
    
    
    
    
    
}
