//
//  YourInterests.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 15/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class YourInterests: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let user_id = UserDefaults.standard.string(forKey: "user_id")
    
    @IBOutlet weak var tableView: UITableView!
    var interest = [InterestClass]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        interestFunc {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "label1", for: indexPath)
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourIntColView", for: indexPath) as! YourIntColView
            
            cell.interest = interest
            cell.collection.reloadData()
            
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "label2", for: indexPath)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "label2", for: indexPath)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return 115
            
        } else if indexPath.row == 1 {
            
            let eachCellHeight = view.frame.size.width / 3 - 8
            let eachRowCell = interest.count / 3
            var totalHeight = CGFloat()
            
            if interest.count % 3 == 0 {
                totalHeight = eachCellHeight * CGFloat(eachRowCell)
            } else {
                totalHeight = eachCellHeight * CGFloat(eachRowCell) + eachCellHeight + 16
            }
            
            return totalHeight
            
        } else if indexPath.row == 2 {
            
            return 180
            
        } else {
            
            return 0
        }
    }


    
    @IBAction func confirmChoices(_ sender: UIButton) {
        
        print(selectedCategory)
        
        if selectedCategory.count == 5 {
            
            let url = baseURL + save_interest + "?"
                + "post_cat_id[0]="
                + "\(selectedCategory[0])"
                + "&post_cat_id[1]="
                + "\(selectedCategory[1])"
                + "&post_cat_id[2]="
                + "\(selectedCategory[2])"
                + "&post_cat_id[3]="
                + "\(selectedCategory[3])"
                + "&post_cat_id[4]="
                + "\(selectedCategory[4])"
                + "&user_id="
                + "\(user_id!)"
            
            print(url)
            
            httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
                
                print(stringData)
                
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                    
                    for json in jsonObject! {
                        
                        if let jsonDic = json as? [String: Any] {
                            
                            
                            if jsonDic["success"] as? Int == 200 {


                                // MOVED CONTROLLER
                                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                let controller = storyboard.instantiateViewController(withIdentifier: "DashboardTab") as! DashboardTab
                                //            controller.email = self.email.text!
                                //            controller.password = self.password.text!
                                
                                self.present(controller, animated: true, completion: nil)

                            }
                            
       
                            
                        }
                        
                    }
                    
                } catch {
                    print("ERROR")
                    DispatchQueue.main.async {
                        snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                    }
                    
                }
            }
            
        } else {
            snackBarFunction(message: "Please seelect 5 categories")
        }
        
        
    }
    
    
    // Interest Function
    func interestFunc(completed: @escaping() -> ()) {
        
        let url = baseURL + select_interest
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
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
   

    // back to previous
    @IBAction func back(_ sender: UIButton) {
        
        // MOVED CONTROLLER
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
        //            controller.email = self.email.text!
        //            controller.password = self.password.text!
        
        self.present(controller, animated: true, completion: nil)

    }
}

// grayscale image noir extension
extension UIImage {
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}


class InterestClass {
    
    var post_cat_id = String()
    var post_cat_name = String()
    var image = String()
}
