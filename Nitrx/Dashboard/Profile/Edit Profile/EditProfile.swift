//
//  EditProfile.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 30/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class EditProfile: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let user_id = UserDefaults.standard.string(forKey: "user_id")
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var website: UITextField!

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    
    var alertController: UIAlertController!
    
    var getProfileImage: String?
    var getName: String?
    var getUsername: String?
    var getAbout: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        UITextField.connectFields(fields: [name, username, website])
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        changeButton.layer.cornerRadius = 20
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 4
        
        textView.delegate = self
        textView.text = "Describe your post here..."
        textView.textColor = UIColor.lightGray
        
        imagePicker()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describe your post here..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    @objc func imageUpload() {
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePicker() {
        
        // alert controller
        alertController = UIAlertController(title: "Add Image", message: "press cancel to main screen", preferredStyle: .actionSheet)
        
        // Gallery Button
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (UIAlertAction) in
            
            let photoPicker = UIImagePickerController()
            photoPicker.delegate = self
            photoPicker.sourceType = .photoLibrary
            self.present(photoPicker, animated: true, completion: nil)
            
            print("Gallery")
        }
        
        // Camera Button
        let camera = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            
            let photoPicker = UIImagePickerController()
            photoPicker.delegate = self
            photoPicker.sourceType = .camera
            self.present(photoPicker, animated: true, completion: nil)
            
            print("Camera")
        }
        
        // Cancel Button
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            print("Cancel")
        }
        
        alertController.addAction(gallery)
        //        alertController.addAction(camera)
        alertController.addAction(cancel)
    }
    
    
    // MARK : - Image Picker controller func
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //        photographPhoto = image.jpegData(compressionQuality: 1)!
            
            profileImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    

    
    
    
    
    
    @IBAction func changeImage(_ sender: UIButton) {
        present(alertController, animated: true, completion: nil)

    }
    
    
    
    @IBAction func saveProfile(_ sender: UIBarButtonItem) {
        post()
    }
    
    func loadData() {
        
        profileImage.loadImageUsingUrlString(urlString: getProfileImage!)
        name.text = getName
        username.text = getUsername
        textView.text = getAbout
    }
    
    //load search data
    func post() {
        
        if textView.text == "Describe your post here..." {
            
            textView.text = ""
        }
        
        var urlComponents = URLComponents(string: baseURL + update_profile_setting)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "first_name", value: name.text),
            URLQueryItem(name: "last_name", value: ""),
            URLQueryItem(name: "about_me", value: textView.text),
            URLQueryItem(name: "location", value: ""),
            URLQueryItem(name: "school", value: ""),
            URLQueryItem(name: "working_at", value: ""),
            URLQueryItem(name: "company_website", value: ""),
            URLQueryItem(name: "website", value: website.text),
            URLQueryItem(name: "relationship", value: ""),
            URLQueryItem(name: "type", value: ""),

        ]
        
        let req = "\((urlComponents.url)!)"
        
        print(req)
        
        httpGet(controller: self, url: req, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([EditProfileClass].self, from: data)
                
                for i in getData {
                    
                    if i.status == "1" {
                        
                        snackBarFunction(message: i.success!)
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
    
    
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // keyboard show and hide
    @objc func keyboardWillShow(notification: NSNotification){
        
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
