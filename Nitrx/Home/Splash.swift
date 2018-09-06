//
//  Splash.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 07/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//


import UIKit

class Splash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // perform segue with delay time
        perform(#selector(showGetStarted), with: nil, afterDelay: 1)
    }


    // perform segue function
    @objc func showGetStarted() {
        performSegue(withIdentifier: "splashSegue", sender: self)
    }

    
}
