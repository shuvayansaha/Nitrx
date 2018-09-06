//
//  Services.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 07/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//



import UIKit
import Alamofire

// MARK : - SOCKET LINK

let socketURL = "ws://ec2-13-126-77-3.ap-south-1.compute.amazonaws.com:8000/api/ws/"

// buy data
let buy_subscribe_broadcast = "buy?subscribe-broadcast"

// sell data
let sell_subscribe_broadcast = "sell?subscribe-broadcast"

// history data
let history_subscribe_broadcast = "history?subscribe-broadcast"

// marrket info
let market_subscribe_broadcast = "market?subscribe-broadcast"


// http://192.168.3.40:4202/#/signin


// MARK : - HTTP LINK

//  base url

// local
//let baseURL = "http://192.168.3.5:9000/api/v1/"

// live
let baseURL = "https://backend.p1r1o2a3s5s8e13t21z.com/api/v1/"

let socketURLS = "http://192.168.3.27:8000/api/v1/"


// live
//let baseURL = "http://35.154.45.8:8000/api/v1/"






let user_registration = "user-registration/"

let user_login = "user-login/"

let update_kyc_details = "update-kyc-details/"

let user_reset_password = "user-reset-password/"

let user_change_password = "user-change-password/"

let update_kyc_documents = "update-kyc-documents/"

let kyc_status_check = "kyc-status-check/"

let kyc_submission_status = "kyc-submission-status/"

let user_resend_mail = "user-resend-mail/"




// wallet

let wallet_details = "wallet-details/"







// sign in
let send_signin_email = "/api/send_signin_email/"

// sign up

// send email
let send_signup_email = "/api/user/send_signup_email/"

// otp
let google_auth = "/api/google_auth/"

// otp check
let signin_otp_check = "/api/signin_otp_check/"

// resend otp check
let signin_resend_otp = "/api/signin_resend_otp/"

// get secret key
let get_secret_key = "/api/get_secret_key/"

// kyc details submit
let user_details_submit = "/api/kyc/user_details_submit/"

// kyc user personal details
let preview = "/api/kyc/preview/"

// kyc file upload
let file_submit = "/api/kyc/file_submit/"

// kyc preview submit

let preview_submit = "/api/kyc/preview_submit/"

// forgot password
let forgot_password = "/api/forgot_password/"

// submit otp on forgotpassword
let submit_otp_on_forgotpassword = "/api/submit_otp_on_forgotpassword/"

// change password forgotpassword
let change_password_forgotpassword = "/api/change_password_forgotpassword/"

// sign out
let revoke = "/api/revoke/"

// notifications
let notifications = "/api/user/notifications/"

// user_notifications_read
let user_notifications_read = "/api/user/user_notifications_read/"

//country api
let countriesUrl = "https://restcountries.eu/rest/v2/all"

// news_feed_list
let news_feed_list = "/api/admin/news_feed_list/"

// Dashboard


//public

let available_pairs_api = "/controller/pair/available_pairs_api/"

let available_pairs = "/controller/pair/available_pairs/"


// trade

let market_data = "/api/public/market/data/"



// Encodable

//struct signIn: Encodable {
//
//    let email: String?
//    let password: String?
//}




// Decodable

struct JSONData: Decodable {

    let status: Bool?
    let isLoginStatus: Bool?
    let otp_type: String?
    let message: MessageData?
    let data: UserData?
}

struct KYCStatusCheck: Decodable {

    let message: String?
}


struct MessageData: Decodable {
    
    let english: String?
    let email: [String]?
    let dob: [String]?

}

struct UserData: Decodable {
    
    let raw_secret_key: String?
    let kyc_status: String?
    let token: String?
    let profile_picture: String?
    let custom_user_id: String?
    let google_authenticated: Bool?
    
    let address: String?
    let city: String?
    let country: String?
    let country_code: String?
    let dob: String?
    let driving_license_back_image: String?
    let driving_license_front_image: String?
    let email: String?
    let first_name: String?
    let identity_proof_number: String?
    let last_name: String?
    let passport_back_image: String?
    let passport_front_image: String?
    let person_holding_passport_back: String?
    let person_holding_passport_front: String?
    let phone_number: String?
    let postal_code: String?
    let state: String?
    let user_profile_image: String?
    
}




//struct Kyc: Decodable {
//
//    
//}







//////////////////////////
struct User: Decodable {
    
    let error: Bool?
    let token: String?
    let super_user_details: [Users]?
    let user_details: [Users]?
    let raw_secret_key: String?
    let secret_key: String?
    let response: [Coins]?
    let kyc_attached_files: KycAttachedFiles?
    let kyc_user_personal_details : KycUserPersonalDetails?
    let notification_list : [NotificationArray]?
    let notification_count : Int?
    let message : String?
    
}



struct MarketData: Decodable {
    
    let response: Coins?
}

struct Coins: Decodable {
    
    let pair_coin: String?
    let coins_list: [CoinList]?
    let fav: [Fav]?
    let response: [SocketValue]?
    
    let title: String?
    let content: String?
    let created_on: String?
    let is_important: Bool?
    let id: Int?

}

struct Fav: Decodable {
    let trade_coin: String?
    let pair_coin: String?
    let pair_id: Int?
    let trade_data: TradeData?
}

struct CoinList: Decodable {
    let trade_coin: String?
    let is_favourite: Bool?
    let id: Int?
    let trade_data: TradeData?
}


struct TradeData: Decodable {

    let change: Float?
    let execution_type: String?
    let high24hr: Float?
    let highestBid: Float?
    let last: Float?
    let low24hr: Float?
    let lowestAsk: Float?
    let percentChange: Float?
    let total24hrVolume: Float?
    let volume: Float?
}

struct NotificationArray: Decodable {
    
    let notification_title: String?
    let notification_id: Int?
    let popup_read: Bool?
    let notification_body: String?
    let read_status: Bool?
    let notification_time: String?
}




struct Users: Decodable {
    
    let user_id: Int?
    let user_details: UserDetails?
}

struct UserDetails: Decodable {
    
    let first_name: String?
    let last_name: String?
    let email: String?
    let phone_no: Int?
    let profile_picture: String?
    let custom_user_id: String?
    let user_kyc_status: String?
    let user_registered_on: String?
    let google_authenticated: Bool?
}



struct Kyc: Decodable {
    
    let kyc_attached_files: KycAttachedFiles?
    let kyc_user_personal_details: KycUserPersonalDetails?
    let userprofile: UserProfile?
    let kyc_status: String?
}

struct KycAttachedFiles: Decodable {
    
    let photo_copy: String?
    
    let passport: String?
    let passport_back: String?

    let person_holding_passport: String?
    let person_holding_passport_back: String?

    let license: String?
    let license_back: String?

}

struct KycUserPersonalDetails: Decodable {
    
    let date_of_birth: String?
    let id_number: String?
    let country: String?
    let id_street_address: String?
    let city: String?
    let state: String?
    let pin: String?
    let phone_no: String?
    let phone_code: String?
}

struct UserProfile: Decodable {
    
    let first_name: String?
    let last_name: String?
    let email: String?
    let phone_no: Int?
    let profile_picture: String?
    let custom_user_id: String?
    let user_kyc_status: String?
    let user_registered_on: String?
    let google_authenticated: Bool?
}


struct Country: Decodable {
    let name: String?
    let flag: String?
    let callingCodes: [String]?

}






// socket
struct WebSocketDecode: Decodable {
    
    let pair : String?
    let data : SocketData?
}

struct SocketData: Decodable {
    
    let status_code: Int?
    let response: [SocketValue]?
}


struct SocketValue: Decodable {
    
    let volume: Float?
    let amount: Float?
    let club_amount: Float?
}








// HTTP POST GLOBAL FUNCTION

func httpPost(controller: UIViewController, url: String, headerValue1: String, headerField1: String, headerValue2: String, headerField2: String, parameters: [String: Any], completionHandler: @escaping (Data, Int, String) -> ()) {
    
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.center = controller.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.activityIndicatorViewStyle = .whiteLarge
    controller.view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
    
    if Connectivity.isConnectedToInternet() {
        print("Yes! internet is available.")
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(headerValue1, forHTTPHeaderField: headerField1)
        request.setValue(headerValue2, forHTTPHeaderField: headerField2)
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                let stringData = ("String Data: \(dataString!)")
                let statusCode = response.statusCode
                
                DispatchQueue.main.async {
                    completionHandler(data, statusCode, stringData)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            } else {
                DispatchQueue.main.async {
                    snackBarFunction(message: (error?.localizedDescription)!)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
            }.resume()
        
    } else {
        snackBarFunction(message: "No Internet Connection.")
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}


// Inter connection checking
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}



// HTTP GET GLOBAL FUNCTION

func httpGet(controller: UIViewController, url: String, headerValue: String, headerField: String, completionHandler: @escaping (Data, Int, String) -> ()) {
    
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.center = controller.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.activityIndicatorViewStyle = .whiteLarge
    controller.view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
    
    if Connectivity.isConnectedToInternet() {
        print("Yes! internet is available.")
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(headerValue, forHTTPHeaderField: headerField)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else { return }
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                let stringData = ("String Data: \(dataString!)")
                let statusCode = response.statusCode

                DispatchQueue.main.async {
                    completionHandler(data, statusCode, stringData)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }

            } else {
                
                DispatchQueue.main.async {
                    snackBarFunction(message: (error?.localizedDescription)!)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
            }.resume()
    } else {
        
        DispatchQueue.main.async {

            snackBarFunction(message: "No Internet Connection.")
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
        
    
}


//class Indiacator {
//
//    // indicator
//    func showIndicatorAlert(message: String, controller: UIViewController) {
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        loadingIndicator.startAnimating();
//        alert.view.addSubview(loadingIndicator)
//        controller.present(alert, animated: true, completion: nil)
//    }
//
//    func hideIndicatorAlert(controller: UIViewController) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//
//
//}



//class LoaderIndicator {
//
//
//    let alert = UIAlertController(title: "", message: "alert ", preferredStyle: .alert)
//
//    func show(controller: UIViewController) {
//        controller.present(alert, animated: true, completion: nil)
//    }
//
//    func hide() {
//        alert.dismiss(animated: true, completion: nil)
//    }
//}
