//
//  PasswordSetup.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 15/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import TextFieldEffects

class PasswordSetup: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var password: HoshiTextField!
    @IBOutlet weak var confirmPassword: HoshiTextField!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var sendLink: UIButton!
    @IBOutlet weak var cancel: UIButton!

    var arrayData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.delegate = self
        password.delegate = self

        sendLink.RoundCornerButton()
        
        hideKeyboardWhenTappedAround()
        
        UITextField.connectFields(fields: [password, confirmPassword])
        
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
        
        if (password.text!.isBlank) {
            
            snackBarFunction(message: "Password field is required.")
        }
            
        else if (password.text!.isPassword == false) {
            
            snackBarFunction(message: "Invalid Password")
        }
            
        else if (confirmPassword.text!.isBlank) {
            
            snackBarFunction(message: "Confirm password field is required.")
        }
            
        else if (confirmPassword.text!.isPassword == false) {
            
            snackBarFunction(message: "Invalid Confirm Password")
        }
            
        else if (password.text != confirmPassword.text) {
            
            snackBarFunction(message: "Confirm password not match.")
            
        }
            
        else {
            passwordSetupFunction()

        }
    }
    
    
    
    
    // cancel
    @IBAction func cancel(_ sender: UIButton) {
        
        // MOVED CONTROLLER
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeNav") as! HomeNav
        self.present(controller, animated: true, completion: nil)
        
    }
    

    
    // reset function
    func passwordSetupFunction() {
        
        let url = baseURL + change_password + "?"
            + "userid=" + "\(arrayData[1])"
            + "&email=" + "\(arrayData[0])"
            + "&varified=" + "\(arrayData[2])"
            + "&password=" + "\(confirmPassword.text!)"

        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([ForgetPasswordClass].self, from: data)
                
                for i in getData {

                    if i.status == "1" {
                        
                        // MOVED CONTROLLER
                        let storyboard = UIStoryboard(name: "Home", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "HomeNav") as! HomeNav
                        self.present(controller, animated: true, completion: nil)
                        
                    } else {

                        if let err = i.errors?.error_text {
                            snackBarFunction(message: err)
                        }
                    }
                }
                
                
                //            // MOVED CONTROLLER
                //            let storyboard = UIStoryboard(name: "Home", bundle: nil)
                //            let controller = storyboard.instantiateViewController(withIdentifier: "HomeNav") as! HomeNav
                //            self.present(controller, animated: true, completion: nil)
                
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
