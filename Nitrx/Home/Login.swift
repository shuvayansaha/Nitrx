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
        
        let url = baseURL + loginUrl + "?" + "username=" + "\(email.text!)" + "&password=" + "\(password.text!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData, statusCode)

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                
                for post in jsonObject! {
                    
                    let postDic = post as? [String: Any]
                    
                    if postDic != nil {
                        
                        if postDic?["login"] != nil {
                            
                            let Address = postDic?["Address"] as! String
                            let DOB = postDic?["DOB"] as! String
                            let email = postDic?["email"] as! String
                            let FirstName = postDic?["First-Name"] as! String
                            let followPrivacy = postDic?["follow-privacy"] as! String
                            let ImagePath = postDic?["Image-Path"] as! String
                            let JoinDate = postDic?["Join-Date"] as! String
                            let LastName = postDic?["Last-Name"] as! String
                            let login = postDic?["login"] as! String
                            let qrimage = postDic?["qrimage"] as! String
                            let status = postDic?["status"] as! String
                            let UserType = postDic?["User-Type"] as! String
                            let username = postDic?["username"] as! String
                            let user_id = postDic?["user_id"] as! String
                            let verified = postDic?["verified"] as! String
                            let Wallet = postDic?["Wallet"] as! String
                            
                            UserDefaults.standard.set(Address, forKey: "Address")
                            UserDefaults.standard.set(DOB, forKey: "DOB")
                            UserDefaults.standard.set(email, forKey: "email")
                            UserDefaults.standard.set(FirstName, forKey: "FirstName")
                            UserDefaults.standard.set(followPrivacy, forKey: "followPrivacy")
                            UserDefaults.standard.set(ImagePath, forKey: "ImagePath")
                            UserDefaults.standard.set(JoinDate, forKey: "JoinDate")
                            UserDefaults.standard.set(LastName, forKey: "LastName")
                            UserDefaults.standard.set(qrimage, forKey: "qrimage")
                            UserDefaults.standard.set(status, forKey: "status")
                            UserDefaults.standard.set(UserType, forKey: "UserType")
                            UserDefaults.standard.set(username, forKey: "username")
                            UserDefaults.standard.set(user_id, forKey: "user_id")
                            UserDefaults.standard.set(verified, forKey: "verified")
                            UserDefaults.standard.set(Wallet, forKey: "Wallet")
                            
                            snackBarFunction(message: login)
                            
                            // MOVED CONTROLLER
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "TermsOfServiceNav") as! TermsOfServiceNav
                            //            controller.email = self.email.text!
                            //            controller.password = self.password.text!
                            
                            self.present(controller, animated: true, completion: nil)
                            
                        }
                        
                        if postDic?["errors"] != nil {
                            
                            let errors = postDic?["errors"] as! [String: Any]
                            
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
