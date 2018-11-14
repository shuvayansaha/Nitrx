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
            
        }
    }
    
    
    
    
    // cancel
    @IBAction func cancel(_ sender: UIButton) {
        
    }
    
    
    
    
    
    // forgot function
    func forgotPasswordFunction() {
        
        let url = baseURL + forget_password + "?" + "email=" + "\(email.text!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for post in jsonObject! {
                    
                    let postDic = post as? [String: Any]
                    
                    if postDic != nil {
                        
                        if postDic?["message"] != nil {
                            
                            let message = postDic?["message"] as! String
                            
                            snackBarFunction(message: message)
                            
                            self.performSegue(withIdentifier: "ResendLink", sender: nil)
                            
                        }
                        
                        if postDic?["error"] != nil {
                            
                            let error = postDic?["error"] as! String
                            
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
