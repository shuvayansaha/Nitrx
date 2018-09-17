//
//  ForgotPassword.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 15/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import TextFieldEffects

class ForgotPassword: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var sendLink: UIButton!
    @IBOutlet weak var cancel: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        
        sendLink.RoundCornerButton()
        
        hideKeyboardWhenTappedAround()
        
        UITextField.connectFields(fields: [email])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)

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
    
    
    
    // send link
    @IBAction func sendLink(_ sender: UIButton) {
        
        if (email.text!.isBlank) {
            
            snackBarFunction(message: "Email field is required.")
        }
            
        else if (email.text!.isEmail == false) {
            
            snackBarFunction(message: "The email must be a valid email address.")
        }
            
        else {
            forgotPasswordFunction()
            
            performSegue(withIdentifier: "ResendLink", sender: nil)
        }
    }
    
    
    
    
    // cancel
    @IBAction func cancel(_ sender: UIButton) {
        
    }
    
    
    
    
    
    // login function
    func forgotPasswordFunction() {
        
        let url = baseURL 
        let parameters = ["email": email.text!]
        
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
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
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
