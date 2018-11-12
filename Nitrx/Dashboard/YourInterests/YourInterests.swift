//
//  YourInterests.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 15/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

//var selectedCategory = [String]()

class YourInterests: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var interestseCol: UICollectionView!
    
    let category = ["News", "Technology", "Film", "Arts", "Music", "Home", "Photography", "Politics", "News", "Technology", "Film", "Arts", "Music", "Home", "Photography", "Politics"]
    
    var selectedCategory = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        interestseCol.delegate = self
        interestseCol.dataSource = self
        interestseCol.allowsMultipleSelection = true
    }

    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
    }
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return category.count
        } else if section == 2 {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 50)
            
        } else if indexPath.section == 1 {
        
            return CGSize(width: collectionView.frame.size.width / 3 - 8, height: collectionView.frame.size.width / 3 - 8)
        
        } else if indexPath.section == 2 {
            
            return CGSize(width: collectionView.frame.size.width, height: 108)

        } else {
            return UICollectionViewFlowLayout.automaticSize
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourIntLabelCell", for: indexPath) as! YourIntLabelCell
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourIntCell", for: indexPath) as! YourIntCell
            
            cell.label.text = category[indexPath.row]
//            cell.image.image = UIImage(named: category[indexPath.row])?.noir
            cell.image.image = UIImage(named: category[indexPath.row])

            cell.check.alpha = 0
            cell.blackView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
            
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourIntButtonCell", for: indexPath) as! YourIntButtonCell
            
            cell.confirmChoices.addTarget(self, action: #selector(confirmChoices), for: .touchUpInside)
            
            return cell
        }

        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourIntButtonCell", for: indexPath) as! YourIntButtonCell
            
            return cell
        }
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionFooter:
            
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "YourIntFooter", for: indexPath) as! YourIntFooter
            
            return footerView
  
        default:
            assert(false, "Unexpected element kind")
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 32)
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! YourIntCell
        
        if indexPath.section == 1 {
            
            if cell.isSelected == true {
                
                cell.label.textColor = UIColor.white
                cell.blackView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
                cell.check.alpha = 1
//                cell.image.image = UIImage(named: category[indexPath.row])

                selectedCategory.append(category[indexPath.row])
                
            } else {
                
                cell.label.textColor = UIColor.black
                cell.blackView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
                cell.check.alpha = 0
//                cell.image.image = UIImage(named: category[indexPath.row])?.noir

                selectedCategory.removeAll { (element) -> Bool in
                    element == category[indexPath.row]
                }
            }
         
            
        }
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath) as! YourIntCell
        
        if indexPath.section == 1 {
            
            if cell.isSelected == true {
                
                cell.label.textColor = UIColor.white
                cell.blackView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
                cell.check.alpha = 1
//                cell.image.image = UIImage(named: category[indexPath.row])

                selectedCategory.append(category[indexPath.row])
                
            } else {
            
                cell.label.textColor = UIColor.black
                cell.blackView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
                cell.check.alpha = 0
//                cell.image.image = UIImage(named: category[indexPath.row])?.noir

                selectedCategory.removeAll { (element) -> Bool in
                    element == category[indexPath.row]
                }
            }
            
            
        }
    }
    
    
    
    
    @objc func confirmChoices() {
        
        print("selected Category", selectedCategory)

        if selectedCategory.count > 5 {
            
            // MOVED CONTROLLER
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DashboardTab") as! DashboardTab
            //            controller.email = self.email.text!
            //            controller.password = self.password.text!
            
            self.present(controller, animated: true, completion: nil)

            
        } else {
            
            snackBarFunction(message: "Please seelect minimum 6 categories")
        }
        
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
