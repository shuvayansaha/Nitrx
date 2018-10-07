//
//  Home.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 16/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Home: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var homeCol: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeCol.delegate = self
        homeCol.dataSource = self
        
        loadHome()

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
        
        return 5
 
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 1000)

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColCell", for: indexPath) as! HomeColCell
        
        return cell
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
