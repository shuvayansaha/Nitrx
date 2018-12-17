//
//  YourIntColView.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 22/11/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
var selectedCategory = [String]()

class YourIntColView: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    @IBOutlet weak var collection: UICollectionView!
    
    var interest = [InterestClass]()
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collection.delegate = self
        collection.dataSource = self
        collection.allowsMultipleSelection = true

        interestFunc {
            self.collection.reloadData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interest.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 3 - 8, height: collectionView.frame.size.width / 3 - 8)
    }
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourIntCell", for: indexPath) as! YourIntCell
        
        cell.label.text = interest[indexPath.row].post_cat_name
//        cell.image.image = UIImage(named: category[indexPath.row])?.noir
         cell.image.loadImageUsingUrlString(urlString: interest[indexPath.row].image)
        
        cell.check.alpha = 0
        cell.blackView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        return cell
    }
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! YourIntCell
        
        if cell.isSelected == true {
            
            cell.label.textColor = UIColor.white
            cell.blackView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
            cell.check.alpha = 1
//            cell.image.image = UIImage(named: category[indexPath.row])
            
            selectedCategory.append(interest[indexPath.row].post_cat_id)
            
        } else {
            
            cell.label.textColor = UIColor.black
            cell.blackView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
            cell.check.alpha = 0
//            cell.image.image = UIImage(named: category[indexPath.row])?.noir
            
            selectedCategory.removeAll { (element) -> Bool in
                element == interest[indexPath.row].post_cat_id
            }
        }
            
            
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! YourIntCell
        
        
        
        if cell.isSelected == true {
            
            cell.label.textColor = UIColor.white
            cell.blackView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
            cell.check.alpha = 1
//            cell.image.image = UIImage(named: category[indexPath.row])
            
            selectedCategory.append(interest[indexPath.row].post_cat_id)
            
        } else {
            
            cell.label.textColor = UIColor.black
            cell.blackView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
            cell.check.alpha = 0
//            cell.image.image = UIImage(named: category[indexPath.row])?.noir
            
            selectedCategory.removeAll { (element) -> Bool in
                element == interest[indexPath.row].post_cat_id
            }
        }
            
            
    }
    
    
    
    // Interest Function
    func interestFunc(completed: @escaping() -> ()) {
        
        let url = baseURL + select_interest
        
        httpGetTableView(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for json in jsonObject! {
                    
                    if let jsonDic = json as? [String: Any] {
                        
                        let interestArray = InterestClass()
                        
                        if let post_cat_id = jsonDic["post_cat_id"] as? String {
                            interestArray.post_cat_id = post_cat_id
                        }
                        if let post_cat_name = jsonDic["post_cat_name"] as? String {
                            interestArray.post_cat_name = post_cat_name
                        }
                        if let image = jsonDic["image"] as? String {
                            interestArray.image = image
                        }
                        
                        self.interest.append(interestArray)
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
