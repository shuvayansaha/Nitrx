//
//  SignUp.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 11/11/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import TextFieldEffects

class SignUp: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        email.delegate = self
        password.delegate = self
        
//        signUpButton.RoundCornerButton()
//        createAccount.RoundCornerButton()
        
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
    @IBAction func signUp(_ sender: UIButton) {
        
        if (email.text!.isBlank) {
            
            snackBarFunction(message: "Email field is required.")
        }
            
        else if (email.text!.isEmail == false) {
            
            snackBarFunction(message: "The email must be a valid email address.")
        }
            
        else if (password.text!.isBlank) {
            
            snackBarFunction(message: "Password field is required.")
        }
            
        else if (password.text!.isPassword == false) {
            
            snackBarFunction(message: "Invalid Password")
        }
            
        else {
            //            loginFunction()
            
            
            // MOVED CONTROLLER
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TermsOfServiceNav") as! TermsOfServiceNav
            //            controller.email = self.email.text!
            //            controller.password = self.password.text!
            
            self.present(controller, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    // login function
    func signUpFunction() {
        
        let url = baseURL + loginUrl
        let parameters = ["email": email.text!, "password": password.text!]
        
        httpPost(controller: self, url: url, headerValue1: "application/json", headerField1: "Content-Type", headerValue2: "application/json", headerField2: "Content-Type", parameters: parameters) { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                let getData = try JSONDecoder().decode(JSONData.self, from: data)
                
                if getData.isLoginStatus == true {
                    if getData.otp_type == "email" {
                        
                        //                        // MOVED CONTROLLER
                        //                        let storyboard = UIStoryboard(name: "Home", bundle: nil)
                        //                        let controller = storyboard.instantiateViewController(withIdentifier: "EmailOtp") as! EmailOtp
                        //                        controller.email = self.email.text!
                        //                        controller.password = self.password.text!
                        //
                        //                        self.present(controller, animated: true, completion: nil)
                        
                    } else {
                        
                        // MOVED CONTROLLER
                        //                        let storyboard = UIStoryboard(name: "Home", bundle: nil)
                        //                        let controller = storyboard.instantiateViewController(withIdentifier: "GAuthOtp") as! GAuthOtp
                        //                        controller.email = self.email.text!
                        //                        controller.password = self.password.text!
                        //
                        //                        self.present(controller, animated: true, completion: nil)
                        
                    }
                    
                } else {}
                
                //                if getData.message?.email != nil {
                //                    snackBarFunction(message: (getData.message?.email![0])!)
                //                } else {
                //                    snackBarFunction(message: (getData.message?.english)!)
                //                }
                
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    

    
    

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
