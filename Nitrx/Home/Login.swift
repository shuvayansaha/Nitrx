//
//  Login.swift
//  Nitrx
//
//  Created by Rplanx on 30/08/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    
    let max = 10.0
    var current = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let x = [1, 2, 3]
        
        let shuffle =  x.shuffled()
        
        print(shuffle)
        
    }

    @IBAction func tap(_ sender: UIButton) {
        
        progressBar.setProgress(Float(current), animated: true)
        perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
        
    }
    
    
    @objc func updateProgress() {
        
        current = current + 1.0
        progressBar.progress = Float(current/max)
        
        if current < max {
            
            perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
        } else {
            current = 0.0
        }
        
    }
    
    
    
    
    
}


extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
