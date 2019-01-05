//
//  CreatePost.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 30/12/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//

import UIKit
import Alamofire

class CreatePost: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    let post_cat_id = UserDefaults.standard.string(forKey: "post_cat_id")
    var id = String()

    @IBOutlet weak var postTitleText: UILabel!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var addKeywords: UITextField!

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var upload: UIButton!
    @IBOutlet weak var save: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadImageButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var whiteView: UIView!
    
    var selectedPicker: String?

    var alertController: UIAlertController!
    
    var interestCategory = [SelectInterestClass]()
    var photoData: Data?
    var photoName: String?
    var select_post_cat_id: String?
    var postArray = [PostsClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ID ***", id, post_cat_id)
        
        hideKeyboardWhenTappedAround()
        
        UITextField.connectFields(fields: [postTitle, url])
        
        whiteView.layer.borderColor = UIColor.lightGray.cgColor
        whiteView.layer.borderWidth = 0.5
        whiteView.layer.cornerRadius = 4
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 4
        
        textView.delegate = self
        textView.text = "Describe additional information about this post..."
        textView.textColor = UIColor.lightGray
        
        upload.layer.cornerRadius = 4
        
        
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 4
        
        uploadImageButton.layer.cornerRadius = 20

        imagePicker()
        picker()


        
//        editPostFunc(postID: id) {
//
//        }
        
        
        selectInterest {
            self.category.text = self.interestCategory[0].post_cat_name
            self.select_post_cat_id = self.interestCategory[0].post_cat_id
        }
        
        
        if id != "" {
            
            title = "Edit Your Post"
            postTitleText.text = "Edit Your Post"
            
            loadPost(postID: id) {
                
                for i in self.postArray {
                    
                    self.postTitle.text = i.postText
                    self.url.text = i.website_url
                    self.textView.text = i.description
                    self.imageView.loadImageUsingUrlString(urlString: i.image!)
                    
//                    let catId = Int(i.post_cat_id!)
                    
//                    if let cat = self.interestCategory[catId!].post_cat_id {
//                        self.postTitle.text = cat
//                    }
                    
       

                }
                
            }
          
        } else {
         
            
        }
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
            textView.text = "Describe additional information about this post..."
            textView.textColor = UIColor.lightGray
        }
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
        
        category.inputView = thePicker
        category.inputAccessoryView = toolbar
    }
    
    @objc func dateDonePressed() {
        
        if selectedPicker == nil {
            self.category.text = interestCategory[0].post_cat_name
            select_post_cat_id = interestCategory[0].post_cat_id

        } else {
            self.category.text = selectedPicker

        }
        self.view.endEditing(true)
    }
    
    // picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return interestCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return interestCategory[row].post_cat_name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.category.text = interestCategory[row].post_cat_name
        selectedPicker = interestCategory[row].post_cat_name
        select_post_cat_id = interestCategory[row].post_cat_id

    }
    
    func imageUpload() {
       
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
            
            imageView.image = image
            photoData = image.jpegData(compressionQuality: 1)!
            if let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                photoName = fileUrl.lastPathComponent
            }
        }
    
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func uploadAction(_ sender: UIButton) {
        
        if photoData != nil {
            
            postCreateFunc()
        }
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        imageUpload()
    }
    
    
    
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        print("cancel")
        
        clearData()


    }
    
    func clearData() {
        
        postTitle.text = nil
        url.text = nil
        category.text = nil
        addKeywords.text = nil
        textView.text = "Describe additional information about this post..."
        textView.textColor = UIColor.lightGray
        imageView.image = nil
        photoName = nil
        photoData = nil
        
        self.category.text = self.interestCategory[0].post_cat_name
        self.select_post_cat_id = self.interestCategory[0].post_cat_id

    }
    
    

    
    
    // image upload alamofire
    func postCreateFunc() {

        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()

//        var urlComponents = URLComponents(string: baseURL + add_post)!
        
//        urlComponents.queryItems = [
//            URLQueryItem(name: "user_id", value: user_id),
//            URLQueryItem(name: "post_cat_id", value: select_post_cat_id),
//            URLQueryItem(name: "website_url", value: url.text),
//            URLQueryItem(name: "postText", value: postTitle.text),
//            URLQueryItem(name: "description", value: textView.text),
//        ]
        
        let link = baseURL + add_post
        
        let parameters = ["user_id":user_id,
                      "post_cat_id":select_post_cat_id,
                      "website_url":url.text,
                      "postText":postTitle.text,
                      "description":textView.text]


        Alamofire.upload(multipartFormData: { (multipartFormData) in

            multipartFormData.append(self.photoData!, withName: "postPhotos", fileName: self.photoName!, mimeType: "image/jpg")
            
            for (key, value) in parameters {
                
                multipartFormData.append((value?.data(using: String.Encoding.utf8))!, withName: key)
            }

        },

                         to: link
            ,
                         headers:["Content-type": "multipart/form-data"]) { (encodingResult) in

                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in

                                    activityIndicator.stopAnimating()
                                    UIApplication.shared.endIgnoringInteractionEvents()

                                    let result = response.result.value as? NSArray
                                    
                                    print(result)
                                    
                                    for i in result! {
                                        
                                        if let data = i as? NSDictionary {
                                            
                                            if let success = data["success"] as? String {
                                                
                                                snackBarFunction(message: success)
                                            }
                                            
                                            if data["status"] as? String == "1" {
                                                
                                                self.clearData()
                                            }
                                            
                                            if let err = data["errors"] as? NSDictionary {
                                                
                                                snackBarFunction(message: err["error_text"] as! String)
                                            }
                                        
                                        }
                                    }
                                    



                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        }

    }
    
    
    //get user data
    func selectInterest(completed: @escaping () -> ()) {
        
        let url = baseURL + select_interest + "?"
            
            + "post_cat_id="
            + "\(post_cat_id!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            //            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([SelectInterestClass].self, from: data)
                
                self.interestCategory = getData
                
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                DispatchQueue.main.async {
                    snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                }
            }
        }
    }
    
    //load post
    func loadPost(postID: String, completed: @escaping () -> ()) {
        
        let url = baseURL + single_post + "?post_id=\(postID)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([PostsClass].self, from: data)
                
                self.postArray = getData
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
                
            }
        }
    }
    
    
    
    // load comments
    func editPostFunc(postID: String, completed: @escaping () -> ()) {
        
        let url = baseURL + edit_post + "?"
            + "post_id=" + "\(postID)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode(ProfileClass.self, from: data)
                
//                for i in getData.posts! {
//                    
//                    if i.api_status != "400" {
//                        
//                        self.posts = getData.posts!
//                        
//                    }
//                }
//                
//                self.profileDetails = getData.profile
                
                DispatchQueue.main.async { completed() }
                
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
