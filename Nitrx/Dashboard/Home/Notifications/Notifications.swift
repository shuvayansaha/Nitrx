//
//  Notification.swift
//  Nitrx
//
//  Created by Shuvayan Saha on 08/01/19.
//  Copyright © 2019 Nitrx. All rights reserved.
//

import UIKit

class Notifications: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notiTableView: UITableView!
    
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    
    var notiArray = [NotificationClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notiTableView.delegate = self
        notiTableView.dataSource = self

        loadNotification {
            
            self.notiTableView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // navigation bar gradient color
        var colors = [UIColor]()
        colors.append(UIColor(red: 61/255, green: 78/255, blue: 253/255, alpha: 1))
        colors.append(UIColor(red: 5/255, green: 183/255, blue: 218/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotiCell", for: indexPath) as! NotiCell
        
        if let img = notiArray[indexPath.row].avatar {
            cell.userImage.imageLoadingUsingUrlString(urlString: img)
        }
        
        if let name = notiArray[indexPath.row].notifier_name {
            cell.userName.text = name
        }
        
        if let type = notiArray[indexPath.row].type {
            cell.notiType.text = type
        }
        
        if let time = notiArray[indexPath.row].time {
            
            let date = Date(timeIntervalSince1970: Double(time)!)
            TimeZone.ReferenceType.default = TimeZone(abbreviation: "IST")!
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.ReferenceType.default
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateTime = formatter.string(from: date)
//            let currentDate = formatter.string(from: Date())

//            let diff = Date().timeIntervalSince1970 - date

            cell.time.text = dateTime
//            cell.time.text = dateTime + "  minutes ago"


        }
        
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40 + 8 + 8
    }
    
    //load home data
    func loadNotification(completed: @escaping () -> ()) {
        
        let url = baseURL + notification + "?user_id=\(user_id!)"
        
        httpGet(controller: self, url: url, headerValue: "application/json", headerField: "Content-Type") { (data, statusCode, stringData) in
            
//            print(stringData)
            
            do {
                
                let getData = try JSONDecoder().decode([NotificationClass].self, from: data)
                
                for i in getData {
                    
                    if let err = i.errors {
                        snackBarFunction(message: err.error_text!)
                        
                        self.notiArray = [NotificationClass]()
                    } else {
                        self.notiArray = getData
                    }
                }
                
                DispatchQueue.main.async { completed() }
                
            } catch {
                print("ERROR")
                snackBarFunction(message: "Internal Server Error:" + " \(statusCode)")
            }
        }
    }
    
    
    
}
