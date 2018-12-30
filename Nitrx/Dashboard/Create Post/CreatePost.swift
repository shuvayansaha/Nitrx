//
//  CreatePost.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 30/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit

class CreatePost: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var upload: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var postView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    var alertController: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        UITextField.connectFields(fields: [postTitle, url])
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 4
        
        textView.delegate = self
        textView.text = "Describe your post here..."
        textView.textColor = UIColor.lightGray
        
        upload.layer.cornerRadius = 4
        
        save.layer.borderColor = blueColor2.cgColor
        save.layer.borderWidth = 1
        save.layer.cornerRadius = 4
        
        postView.layer.borderColor = UIColor.lightGray.cgColor
        postView.layer.borderWidth = 0.5
        postView.layer.cornerRadius = 4
        
        postView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageUpload)))
        
        imagePicker()
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
        }
    
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func uploadAction(_ sender: UIButton) {
        post()
    }
    
    
    
    
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        
    }
    
    
    
    //load search data
    func post() {
        
        if textView.text == "Describe your post here..." {
            
           textView.text = ""
        }
        
        var urlComponents = URLComponents(string: baseURL + postUrl)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "post_cat_id", value: "2"),
            URLQueryItem(name: "website_url", value: url.text),
            URLQueryItem(name: "postText", value: postTitle.text),
            URLQueryItem(name: "description", value: textView.text)
        ]
        
        let req = "\((urlComponents.url)!)"
        
        print(req)

        httpGet(controller: self, url: req, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([SendCommentsClass].self, from: data)
                
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
