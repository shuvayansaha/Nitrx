//
//  TermsOfService.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 22/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class TermsOfService: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var colView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colView.delegate = self
        colView.dataSource = self
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
            return CGSize(width: collectionView.frame.size.width, height: 40)
            
        } else if indexPath.row == 1 {
            
            let approximateWidthOfTextView = collectionView.frame.size.width - 32 - 16
            
            let size = CGSize(width: approximateWidthOfTextView, height: 1000)
            
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]

            let estimatedFrame = NSString(string: txt).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            return CGSize(width: collectionView.frame.size.width, height: estimatedFrame.height + 32 + 16 + 14)
            
        } else if indexPath.row == 2 {
            return CGSize(width: collectionView.frame.size.width, height: 80)
            
        } else {
            return UICollectionViewFlowLayout.automaticSize
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TermsServiceHeaderCell", for: indexPath) as! TermsServiceHeaderCell
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TermsServiceCell", for: indexPath) as! TermsServiceCell
            
            cell.label.text = txt
            
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TermsOfServiceButtonCell", for: indexPath) as! TermsOfServiceButtonCell
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TermsOfServiceButtonCell", for: indexPath) as! TermsOfServiceButtonCell
            
            return cell
            
        }
    }
}


let txt = "sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including !"
