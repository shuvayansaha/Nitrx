//
//  Constant.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 19/10/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class Constant {
    
    static var totalItem = CGFloat()
    
    static let column: CGFloat = 2
    
    static let minLineSpacing: CGFloat = 3.0
    static let minItemSpacing: CGFloat = 3.0
    
    static let offset: CGFloat = 3.0 // TODO: for each side, define its offset
    
    static func getItemWidth(boundWidth: CGFloat) -> CGFloat {
        
        let totalWidth = boundWidth - (offset + offset) - ((column - 1) * minItemSpacing)
        
        return totalWidth / column
    }
}
