//
//  ResendLink.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 15/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import TextFieldEffects

class ResendLink: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: HoshiTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var sendLink: UIButton!
    @IBOutlet weak var cancel: UIButton!

    var hiddenCode = String()
    
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
            
            snackBarFunction(message: "Code field is required.")
        }
            
        else {
            resetPasswordFunction()

        }
    }
    
    
    
    
    // cancel
    @IBAction func cancel(_ sender: UIButton) {
        
    }
    

    
    

    // reset function
    func resetPasswordFunction() {
        
        let url = baseURL + reset_password + "?"
            + "hidden_code=" + "\(hiddenCode)"
            + "&code=" + "\(email.text!)"

        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([ForgetPasswordClass].self, from: data)
                
                for i in getData {

                    if i.status == "1" {
                        
                        snackBarFunction(message: i.message!)
                        
                        let data = [i.email, i.userid, i.varified]

                        self.performSegue(withIdentifier: "PasswordSetup", sender: data)

                    } else {

                        if let err = i.errors?.error_text {
                            snackBarFunction(message: err)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "PasswordSetup") {
            let vc = segue.destination as! PasswordSetup
            
            vc.arrayData =  sender as! [String]
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
