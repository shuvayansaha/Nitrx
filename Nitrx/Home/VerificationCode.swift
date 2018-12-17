//
//  VerificationCode.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 16/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class VerificationCode: UIViewController {

    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        verifyButton.RoundCornerButton()

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
    
    @IBAction func verifyAccount(_ sender: UIButton) {

        if (code.text!.isBlank) {
            
            snackBarFunction(message: "Code field is required.")
            
        } else {
            
            verifyFunction()
        }
        
    }
    
    
    // login function
    func verifyFunction() {
        
        let url = baseURL + verify_email + "?"
            + "code="
            + "\(code.text!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                
                for json in jsonObject! {
                    
                    if let jsonDic = json as? [String: Any] {
                        
                        if jsonDic["status"] as? String == "1" {
                            
                            self.presentAlertWithAction(title: "Success", message: "Succesfully Verified Your Account !", buttonText: "Go to Terms & Conditions", completion: {
                                
                                // MOVED CONTROLLER
                                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                let controller = storyboard.instantiateViewController(withIdentifier: "TermsOfServiceNav") as! UINavigationController
                                self.present(controller, animated: true, completion: nil)
                            })
                            
                            self.view.endEditing(true)
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
        return newLength <= 10
    }
}
