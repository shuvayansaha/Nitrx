//
//  Services.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 07/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//



import UIKit
import Alamofire

// MARK : - HTTP LINK

// live
let baseURL = "http://json.nitrx.com/"

let loginUrl = "login.php/"


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




























// HTTP POST GLOBAL FUNCTION

func httpPost(controller: UIViewController, url: String, headerValue1: String, headerField1: String, headerValue2: String, headerField2: String, parameters: [String: Any], completionHandler: @escaping (Data, Int, String) -> ()) {
    
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.center = controller.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .whiteLarge
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
    activityIndicator.style = .gray
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
