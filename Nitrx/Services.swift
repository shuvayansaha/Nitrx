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
let comment = "comment.php/"
let verify_email = "verify_email.php/"
let select_interest = "select_interest.php/"
let save_interest = "save_interest.php/"
let post_details = "post_details.php/"
let save_comment = "save_comment.php/"
let profile = "profile.php/"
let get_user_data = "get_user_data.php/"
let reset_password = "reset_password.php/"
let change_password = "change_password.php/"









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





// send comment

struct SendCommentsClass: Codable {

    let status: String?
    let errors: ErrorsClass?
}

struct ErrorsClass: Codable {
    let error_text: String?
    let status: String?
}




struct CommentsClass: Codable {
    
    let comment_id: String?
    let comment_reply: [CommentsReplyClass]?
    let post_id: String?
    let post_user_id: String?
    let text: String?
    let time: String?
    let username: String?
    let user_avater: String?
    let user_id: String?
    let user_rate: String?

}


struct CommentsReplyClass: Codable {
    
    let text: String?
    let time: String?
    let username: String?
    let user_avater: String?

  
}



// profile
struct ProfileClass: Codable {
    
    let profile: ProfileDetailsClass?
    let posts: [PostsClass]?
}


struct ProfileDetailsClass: Codable {
    
    let about: String?
    let Address: String?
    let countFollowers: String?
    let countFollowing: String?
    let countUserPosts: String?
    let DOB: String?
    let email: String?
    let first_name: String?
    let follow_privacy: String?
    let Gender: String?
    let image_path: String?
    let Join_Date: String?
    let last_name: String?
    let points: String?
    let post_cat_id: String?
    let preference: String?
    let qrimage: String?
    let status: String?
    let User_Type: String?
    let username: String?
    let user_id: String?
    let user_score: Int?
    let verified: String?
}




struct PostsClass: Codable {

    let avg_post_rate: Int?
    let comments: Int?
    let description: String?
    let first_name: String?
    let image: String?
    let last_name: String?
//    let ncoins: Int?
    let postText: String?
    let post_cat_id: String?
    let post_date: String?
    let post_id: String?
    let profile_id: String?
    let qrimage: String?
    let status: String?
    let user_avatar: String?
    let view_count: Int?
    let website_url: String?
    let errors: ErrorsClass?
    let api_status: String?

}


struct UserDataClass: Codable {
    
    let avg_post_rate: Int?
    let comments: Int?
    let description: String?
    let first_name: String?
    let image: String?
    let last_name: String?
    //    let ncoins: Int?
    let postText: String?
    let post_cat_id: String?
    let post_date: String?
    let post_id: String?
    let profile_id: String?
    let qrimage: String?
    let status: String?
    let user_avatar: String?
    let view_count: Int?
    let website_url: String?
    
}


struct SelectInterestClass: Codable {

    let image: String?
    let post_cat_id: String?
    let post_cat_name: String?
    let status: String?

}


struct ForgetPasswordClass: Codable {
    
    let message: String?
    let hidden_code: String?
    let status: String?
    let error: String?

    let email: String?
    let page_name: String?
    let varified: String?
    let userid: String?
    let errors: ErrorsClass?


}
