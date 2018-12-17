//
//  Login.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 08/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import TextFieldEffects

class Login: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        password.delegate = self
        
        loginButton.RoundCornerButton()
        createAccount.RoundCornerButton()

        hideKeyboardWhenTappedAround()
        
        UITextField.connectFields(fields: [email, password])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
    }
    
    
    // login button
    @IBAction func login(_ sender: UIButton) {
        
        if (email.text!.isBlank) {
            
            snackBarFunction(message: "Email or Username field is required.")
        }
            
//        else if (email.text!.isEmail == false) {
//
//            snackBarFunction(message: "The email must be a valid email address.")
//        }
            
        else if (password.text!.isBlank) {
            
            snackBarFunction(message: "Password field is required.")
        }
            
//        else if (password.text!.isPassword == false) {
//
//            snackBarFunction(message: "Invalid Password")
//        }
            
        else {
            
            loginFunction()

        }
    }
    

    
    
    // login function
    func loginFunction() {
        
        let url = baseURL + loginUrl + "?"
            + "username=" + "\(email.text!)"
            + "&password=" + "\(password.text!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for json in jsonObject! {
                    
                    if let jsonDic = json as? [String: Any] {
                        
                        if jsonDic["status"] as? String == "1" {
                            
//                            let Address = jsonDic["Address"] as! String
//                            let DOB = jsonDic["DOB"] as! String
//                            let email = jsonDic["email"] as! String
//                            let FirstName = jsonDic["First-Name"] as! String
//                            let followPrivacy = jsonDic["follow-privacy"] as! String
//                            let ImagePath = jsonDic["Image-Path"] as! String
//                            let JoinDate = jsonDic["Join-Date"] as! String
//                            let LastName = jsonDic["Last-Name"] as! String
//                            let login = jsonDic["login"] as! String
//                            let qrimage = jsonDic["qrimage"] as! String
//                            let status = jsonDic["status"] as! String
//                            let UserType = jsonDic["User-Type"] as! String
//                            let username = jsonDic["username"] as! String
                            let user_id = jsonDic["user_id"] as! String
//                            let verified = jsonDic["verified"] as! String
//                            let Wallet = jsonDic["Wallet"] as! String
                            
//                            UserDefaults.standard.set(Address, forKey: "Address")
//                            UserDefaults.standard.set(DOB, forKey: "DOB")
//                            UserDefaults.standard.set(email, forKey: "email")
//                            UserDefaults.standard.set(FirstName, forKey: "FirstName")
//                            UserDefaults.standard.set(followPrivacy, forKey: "followPrivacy")
//                            UserDefaults.standard.set(ImagePath, forKey: "ImagePath")
//                            UserDefaults.standard.set(JoinDate, forKey: "JoinDate")
//                            UserDefaults.standard.set(LastName, forKey: "LastName")
//                            UserDefaults.standard.set(qrimage, forKey: "qrimage")
//                            UserDefaults.standard.set(status, forKey: "status")
//                            UserDefaults.standard.set(UserType, forKey: "UserType")
//                            UserDefaults.standard.set(username, forKey: "username")
                            UserDefaults.standard.set(user_id, forKey: "user_id")
//                            UserDefaults.standard.set(verified, forKey: "verified")
//                            UserDefaults.standard.set(Wallet, forKey: "Wallet")
                            
                            
                            if jsonDic["verified"] as? String == "YES" {
                                
                                if jsonDic["preference"] as? String == "YES" {

                                    // MOVED CONTROLLER
                                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                    let controller = storyboard.instantiateViewController(withIdentifier: "DashboardTab") as! DashboardTab
                                    
                                    //            controller.email = self.email.text!
                                    //            controller.password = self.password.text!
                                    self.present(controller, animated: true, completion: nil)
                                    
                                }
                                
                                if jsonDic["preference"] as? String == "NO" {
                                    
                                    // MOVED CONTROLLER
                                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                    let controller = storyboard.instantiateViewController(withIdentifier: "DashboardNav") as! DashboardNav
                                    //            controller.email = self.email.text!
                                    //            controller.password = self.password.text!
                                    self.present(controller, animated: true, completion: nil)
                                    
                                }
                                
                           
                            }
                            
                            if jsonDic["verified"] as? String == "NO" {
                                
                                // MOVED CONTROLLER
                                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                                let controller = storyboard.instantiateViewController(withIdentifier: "VerificationNav") as! UINavigationController
                                //            controller.email = self.email.text!
                                //            controller.password = self.password.text!
                                self.present(controller, animated: true, completion: nil)
                            }
                            
                            
                        }
                        
                        if jsonDic["errors"] != nil {
                            
                            let errors = jsonDic["errors"] as! [String: Any]
                            let error = errors["error_text"] as! String
                            
                            snackBarFunction(message: error)
                            
                        }
                        
                    }
                    
                    
                    
                        
                        
                        
                        
                }
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }

            }
        }
        

    }
    
    
    // forgot password
    @IBAction func forgotPassword(_ sender: UIButton) {}
    

    // create account
    @IBAction func createAccount(_ sender: UIButton) {}
    
    
    
    
    
    
    
    // text limit
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 60
    }
    
    
    // keyboard show and hide
    @objc func keyboardWillShow(notification: NSNotification) {
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
}
