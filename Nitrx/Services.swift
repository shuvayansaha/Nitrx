//
//  Services.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 07/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//



import UIKit

// MARK : - HTTP LINK

// live
let baseURL = "http://json.nitrx.com/"

let loginUrl = "login.php/"
let registerUrl = "register.php/"
let forget_password = "forget_password.php/"


let normal_feeds = "normal_feeds.php/"




struct JSONData: Codable {
    
    let status: Bool?
    let isLoginStatus: Bool?
    let otp_type: String?
    let dic: [NormalFeeds]?
}

struct LoginData: Codable {
    

    let user_id: String?
    let username: String?

    
}






struct NormalFeeds: Codable {
    
    let description: String?
    let postFile: String?
    let postText: String?
    let post_cat_id: String?
    let post_id: String?
    let status: String?
    let username: String?
    let user_id: String?
    let website_url: String?

}





























