//
//  NotificationViewController.swift
//  NIBM Covid 19
//
//  Created by TM on 9/13/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class NotificationViewController: UIViewController {

    var tableView = UITableView()
    var notificationArr = [Notification]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        view.backgroundColor = UIColor.backgroundColor
        getNotification()
        
//        let userID = Auth.auth().currentUser?.uid

//        print("hello.......")
//        Service.shared.fetchNotifications(uid: userID!) { (Notification) in
//            print(Notification.text)
//        }
//        print("hello.......")
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy HH:mm"
//
//
//        let values = [
//        "title": "Hello",
//        "text": "This is a test Notification",
//        "created": formatter.string(from: date),
//        ] as [String : Any]
//        let userID = Auth.auth().currentUser?.uid
//        Database.database().reference().child("notifications").child("Hello 2").updateChildValues(values) { (error, ref) in
//                        print("Successfuly Registerd and save data..")
//        }

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setTableView(){
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        
        self.view.addSubview(tableView)
        
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    private func getNotification(){
        showUniversalLoadingView(true, loadingText: "Fetching Data..")
        
        Database.database().reference().child("notifications").observe(.value, with: { (snapshot) in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let dict = child.value as? [String : AnyObject] ?? [:]
                self.notificationArr.append(Notification( title: dict["title"] as! String, text: dict["text"] as! String, created: dict["created"] as! String))

            }
            self.setTableView()

            showUniversalLoadingView(false, loadingText: "")
            
        }) { (error) in
            showUniversalLoadingView(false, loadingText: "")
            let uialert = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: UIAlertController.Style.alert)
            uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(uialert, animated: true, completion: nil)
            return
        }
    }
    
}


extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NotificationTableViewCell else {fatalError("Unabel to create cell")}
//        cell.userImage.image = userArr[indexPath.row].userImage
        cell.namelbl.text = notificationArr[indexPath.row].title
        cell.agelbl.text = notificationArr[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
