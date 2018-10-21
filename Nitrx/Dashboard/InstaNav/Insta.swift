//
//  Insta.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 19/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Insta: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    
    
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaTableCell", for: indexPath) as! InstaTableCell
        
        return cell
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let itemHeight = Constant.getItemWidth(boundWidth: tableView.bounds.size.width)
        
        let totalRow = ceil(Constant.totalItem / Constant.column)
        
        let totalTopBottomOffset = Constant.offset + Constant.offset
        
        let totalSpacing = CGFloat(totalRow - 1) * Constant.minLineSpacing
        
        let totalHeight  = ((itemHeight * CGFloat(totalRow)) + totalTopBottomOffset + totalSpacing)
        
        return totalHeight
        
        
//        return 1500

        
    }
    
 

    @IBAction func tap(_ sender: Any) {
        
        if blankArray.count > 5 {
            print("Array Print", blankArray)

        } else {
            
            print("Please select 5 items")

        }
    }
    
}
