//
//  Entropy.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 07/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//


import UIKit

class Entropy: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var entropyCollection: UICollectionView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let max = 1.0
    var current = 0.0
    
    var numberArray = [
        
"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
"1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
"2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2",
"3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3",
"4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4",
"5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5",
"6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6",
"7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7",
"8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8",
"9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9",

 "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A",
 "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B",
 "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C",
 "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D",
 "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E",
 "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F",
 
]
    
   
    
    var numberArray2 = [
        
        "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
        "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
        "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "2",
        "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3",
        "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4",
        "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5",
        "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6",
        "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7",
        "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8", "8",
        "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9", "9",
        
        "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A", "A",
        "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B", "B",
        "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C", "C",
        "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D", "D",
        "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E",
        "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F",
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entropyCollection.delegate = self
        entropyCollection.dataSource = self
        
        entropyCollection.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(tap)))
        
        progressBar.setProgress(Float(current), animated: true)

        
    }


        
    

    // collectionview
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16 * 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "EntropyCell", for: indexPath) as! EntropyCell
        
         cell.label.text = numberArray[indexPath.row]
        
        let randomIndex = Int(arc4random_uniform(UInt32(numberArray.count)))
        let randomItem = numberArray[randomIndex]

        if numberArray[indexPath.row] == randomItem {
            cell.label.textColor = UIColor.green
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.width/16, height: collectionView.frame.size.height/16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    @objc func tap(sender: UIPanGestureRecognizer) {
        
        current = current + 0.019
        progressBar.progress = Float(current)
        
        numberArray = numberArray.shuffled()
        
        entropyCollection.reloadData()
        
        if current > max {
            
            current = 0.0
            progressBar.setProgress(Float(current), animated: true)
            numberArray = numberArray2
            
            // MOVED CONTROLLER
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PageController") as! PageController
//            controller.email = self.email.text!
//            controller.password = self.password.text!
            
            self.present(controller, animated: true, completion: nil)
            
        } else {}
    }


    
    // more info
    @IBAction func moreInfo(_ sender: UIButton) {
        
        let data = "By moving your finger, you create random data called entropy, that is used to generate the key pair , associated with new unique Nitrx ID. the key pair consists public key that is distrubuted to your friends and the private key that safely stored ony your phone. Your friends will encript messages to you with your public key. Only the owner of the private key and nobody else is able to decrypt this messages."

        let alertController = UIAlertController(title: "", message: data, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
      
        
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}





