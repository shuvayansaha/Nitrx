//
//  Extension.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 07/09/18.
//  Copyright © 2018 Nitrx. All rights reserved.
//




import UIKit
import TTGSnackbar
import Alamofire

// button border extension
extension UIButton {
    func RoundCornerButtonWithGrayBorder() {
      
        //round corner button
        
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor


    }
    
    func RoundCornerButton() {
        
        //round corner button
        
        self.layer.cornerRadius = 3
        
        
    }
}


extension UIView {
    func ViewBorder() {
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        
    }
}

extension UIViewController {
    
    func presentAlertWithAction(title: String, message: String, buttonText: String, completion: @escaping() -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        alertController.addAction(UIAlertAction(title: buttonText, style: .default, handler: { (action) in
            completion()
        }))
 
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector
            (UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

    


    /*
    
    class Indiacator {
    
        var activityIndicator = UIActivityIndicatorView()

        // indicator
        func displayIndicatorAlert(message: String, controller: UIViewController) {
            
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            alert.view.addSubview(loadingIndicator)
            controller.present(alert, animated: true, completion: nil)
        }
    }

 */

}

// button border each side
extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}


// MARK : - Text field Validation
extension String {
    
    // To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    
    // Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    // Validate Phone No
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }

    }
    

    
    // Validate Only No
    var isNumber : Bool {
        get {
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
    
    

    //Validate password

    var isPassword: Bool {
        let passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{4,}$"
//        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"

        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
}



// Keyboard Next Button
extension UITextField {
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
    // place holder color extension
    func placeHolderColor() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}

extension UITextField {
    func setBottomBorder() {

        let border = CALayer()
        let width = CGFloat(0.3)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

// snackbar function
func snackBarFunction(message: String) {
    
    let snackbar = TTGSnackbar(message: message, duration: .middle)
    snackbar.backgroundColor = .red
    snackbar.animationType = .slideFromTopBackToTop
    snackbar.show()
}


extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleToFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
}

// load image from url

//let imageCache = NSCache<AnyObject, AnyObject>()

//class CustomImageView: UIImageView {
extension UIImageView {
    
    //var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        //imageUrlString = urlString
        let url = URL(string: urlString)
        
        image = nil
        
        //        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
        //
        //            self.image = imageFromCache
        //            return
        //        }
        //
        
        if url != nil {
            
            URLSession.shared.dataTask(with: url!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    
                    let imageToCache =  UIImage(data: data)
                    
                    //                if self.imageUrlString == urlString {
                    //                    self.image = imageToCache
                    //                }
                    self.image = imageToCache
                    
                }
                }.resume()
            
        }
        

    }
    
    
}


// animated loader

class LoaderAnimation {
    
    let window = UIApplication.shared.keyWindow
//    let imageView = UIImageView()



    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)

    
    func loaderShow(controller: UIViewController) {
        
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.tag = 999
        window?.addSubview(blurEffectView)
        
//        imageView.loadGif(name: "noname_loader")

        let image = UIImage(named: "logoIcon")
        let imageView = UIImageView(image: image!)
        
        imageView.contentMode = .scaleAspectFit

        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = controller.view.center
        blurEffectView.contentView.addSubview(imageView)
        
//        UIView.animate(withDuration: 0.5, delay: 0, animations: {
//            controller.view.layoutIfNeeded()
//        }, completion: nil)
    }
    
    func loaderHide(controller: UIViewController) {
        
        self.window?.viewWithTag(999)?.removeFromSuperview()
//        UIView.animate(withDuration: 0.3, delay: 0, animations: {
//            controller.view.layoutIfNeeded()
//        }, completion: nil)
    }
    
}




extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}



extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
}

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}












extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}



// HTTP POST GLOBAL FUNCTION

func httpPost(controller: UIViewController, url: String, headerValue1: String, headerField1: String, headerValue2: String, headerField2: String, parameters: [String: Any], completionHandler: @escaping (Data, Int, String) -> ()) {
    
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.center = controller.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .gray
    controller.view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
    
    if Connectivity.isConnectedToInternet() {
        print("Yes! internet is available.")
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(headerValue1, forHTTPHeaderField: headerField1)
        request.setValue(headerValue2, forHTTPHeaderField: headerField2)
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                let stringData = ("String Data: \(dataString!)")
                let statusCode = response.statusCode
                
                DispatchQueue.main.async {
                    completionHandler(data, statusCode, stringData)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            } else {
                DispatchQueue.main.async {
                    snackBarFunction(message: (error?.localizedDescription)!)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
            }.resume()
        
    } else {
        snackBarFunction(message: "No Internet Connection.")
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}


// Inter connection checking
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}



// HTTP GET GLOBAL FUNCTION

func httpGet(controller: UIViewController, url: String, headerValue: String, headerField: String, completionHandler: @escaping (Data, Int, String) -> ()) {
    
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.center = controller.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .gray
    controller.view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
    
    if Connectivity.isConnectedToInternet() {
        print("Yes! internet is available.")
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(headerValue, forHTTPHeaderField: headerField)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else { return }
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                let stringData = ("String Data: \(dataString!)")
                let statusCode = response.statusCode
                
                DispatchQueue.main.async {
                    completionHandler(data, statusCode, stringData)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                
            } else {
                
                DispatchQueue.main.async {
                    snackBarFunction(message: (error?.localizedDescription)!)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
            }.resume()
    } else {
        
        DispatchQueue.main.async {
            
            snackBarFunction(message: "No Internet Connection.")
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    
}

func httpGetTableView(controller: UITableViewCell, url: String, headerValue: String, headerField: String, completionHandler: @escaping (Data, Int, String) -> ()) {
    
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.center = controller.contentView.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = .gray
    controller.contentView.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
    
    if Connectivity.isConnectedToInternet() {
        print("Yes! internet is available.")
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(headerValue, forHTTPHeaderField: headerField)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else { return }
                guard let data = data else { return }
                let dataString = String(data: data, encoding: .utf8)
                let stringData = ("String Data: \(dataString!)")
                let statusCode = response.statusCode
                
                DispatchQueue.main.async {
                    completionHandler(data, statusCode, stringData)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                
            } else {
                
                DispatchQueue.main.async {
                    snackBarFunction(message: (error?.localizedDescription)!)
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
            }.resume()
    } else {
        
        DispatchQueue.main.async {
            
            snackBarFunction(message: "No Internet Connection.")
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    
}


//class Indiacator {
//
//    // indicator
//    func showIndicatorAlert(message: String, controller: UIViewController) {
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        loadingIndicator.startAnimating();
//        alert.view.addSubview(loadingIndicator)
//        controller.present(alert, animated: true, completion: nil)
//    }
//
//    func hideIndicatorAlert(controller: UIViewController) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//
//
//}



//class LoaderIndicator {
//
//
//    let alert = UIAlertController(title: "", message: "alert ", preferredStyle: .alert)
//
//    func show(controller: UIViewController) {
//        controller.present(alert, animated: true, completion: nil)
//    }
//
//    func hide() {
//        alert.dismiss(animated: true, completion: nil)
//    }
//}



//extension UIViewController: UITextFieldDelegate {
//    func addToolBar(textField: UITextField, txtView: UIView) {
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        
//        let customItem = UIBarButtonItem(customView: txtView)
//        //        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
//        //        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        
//        toolBar.setItems([customItem], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        toolBar.sizeToFit()
//        
//        textField.delegate = self
//        textField.inputAccessoryView = toolBar
//    }
//    @objc func donePressed() {
//        view.endEditing(true)
//    }
//    
//    @objc func cancelPressed() {
//        view.endEditing(true)
//    }
//}
