//
//  SignUp.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 11/11/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class SignUp: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    
    let genderArray = ["Male", "Female"]

    var selectedPicker: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        username.delegate = self
        email.delegate = self
        gender.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        
        loginButton.RoundCornerButton()
        createAccount.RoundCornerButton()
        
        hideKeyboardWhenTappedAround()
        
        UITextField.connectFields(fields: [username, email, gender, password, confirmPassword])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        
        picker()

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
    
    func picker() {
        
        let thePicker = UIPickerView()

        thePicker.dataSource = self
        thePicker.delegate = self
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
    
//       toolbar.barTintColor = UIColor.clear
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        let blankSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([blankSpace, done], animated: true)
        
        gender.inputView = thePicker
        gender.inputAccessoryView = toolbar
    }
    
    @objc func dateDonePressed() {
        
        if selectedPicker == nil {
            self.gender.text = "Male"
        } else {
            self.gender.text = selectedPicker
        }
        self.view.endEditing(true)
    }
    
    // picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.gender.text = genderArray[row]
        selectedPicker = genderArray[row]
    }
    
    
   
    
    
    // login button
    @IBAction func createAccount(_ sender: UIButton) {
        
        if (username.text!.isBlank) {
            
            snackBarFunction(message: "Username field is required.")
       
        } else if (email.text!.isBlank) {
            
            snackBarFunction(message: "Email field is required.")
        }
            
        else if (email.text!.isEmail == false) {
            
            snackBarFunction(message: "The email must be a valid email address.")
       
        } else if (gender.text!.isBlank) {
            
            snackBarFunction(message: "Gender must be selected")
        }
            
        else if (password.text!.isBlank) {
            
            snackBarFunction(message: "Password field is required.")
        }
            
//        else if (password.text!.isPassword == false) {
//            
//            snackBarFunction(message: "Invalid Password")
//       
//        }
        
        else if (confirmPassword.text!.isBlank) {
            
            snackBarFunction(message: "Confirm Password field is required.")
       
        } else if (password.text! != confirmPassword.text!) {
            
            snackBarFunction(message: "Confirm Password not matched with Password.")
       
        } else {

            signUpFunction()
        }
    }
    
    // login action
    @IBAction func loginAction(_ sender: UIButton) {
        
        // MOVED POP CONTROLLER
        _ = navigationController?.popViewController(animated: true)
 
    }
    
    
    // login function
    func signUpFunction() {
        
         let url = baseURL + registerUrl + "?"
            + "username="
            + "\(username.text!)"
            + "&email="
            + "\(email.text!)"
            + "&pwd="
            + "\(confirmPassword.text!)"
            + "&gender="
            + "\(gender.text!)"
            + "&nxit="
            + "\("")"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in

            print(stringData)
            
            do {

                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for json in jsonObject! {
                    
                    if let jsonDic = json as? [String: Any] {
                        
                        if jsonDic["status"] as? String == "1" {
                        
                            if let success = jsonDic["success"] as? String {
                                
                                self.presentAlertWithAction(title: "Success !", message: success, buttonText: "Verify Your Account", completion: {
                                    
                                    // MOVED CONTROLLER
                                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                                    let controller = storyboard.instantiateViewController(withIdentifier: "VerificationNav") as! UINavigationController
                                    self.present(controller, animated: true, completion: nil)
                                })

                            }
//                            let username = jsonDic["username"] as? String
//                            let email = jsonDic["email"] as? String
//                            let gender = jsonDic["gender"] as? String
                        }
                    
                
                        if let errors = jsonDic["errors"] as? [String: Any] {
                            if let error = errors["error_text"] as? String {
                                snackBarFunction(message: error)
                            }
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
