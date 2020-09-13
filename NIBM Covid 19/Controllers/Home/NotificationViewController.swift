//
//  NotificationViewController.swift
//  NIBM Covid 19
//
//  Created by TM on 9/13/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserModal {
    var name: String?
    var age: String?
    
    init(name: String, age: String) {
        self.name = name
        self.age = age
    }
}

class NotificationViewController: UIViewController {

    var tableView = UITableView()
    var userArr = [UserModal]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        view.backgroundColor = UIColor.backgroundColor
        setTableView()
        getNotification()
        
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
//
//        Database.database().reference().child("notifications").updateChildValues(values) { (error, ref) in
//                        print("Successfuly Registerd and save data..")
//                    }

        
        
        userArr.append(UserModal( name: "Amber Heard", age: "32"))
        userArr.append(UserModal( name: "Emma Stone", age: "30"))
        userArr.append(UserModal( name: "Natalie Portman", age: "37"))
        userArr.append(UserModal( name: "Emma Watson", age: "28"))
        userArr.append(UserModal( name: "Angelina Jolie", age: "43"))
        userArr.append(UserModal( name: "Scarlett Johansson", age: "34"))
        userArr.append(UserModal( name: "Jennifer Lawrence", age: "28"))
        userArr.append(UserModal( name: "Charlize Theron", age: "43"))
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
//        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("notifications").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user body temparature value
            let value = snapshot.value as? NSDictionary
//            var temparature = value?["bodyTemperature"] as? String ?? ""
//            let temparatureUpdated = value?["bodyTemperatureUpdated"] as? String ?? ""
            
            print(value)
            

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
        return userArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NotificationTableViewCell else {fatalError("Unabel to create cell")}
//        cell.userImage.image = userArr[indexPath.row].userImage
        cell.namelbl.text = userArr[indexPath.row].name
        cell.agelbl.text = userArr[indexPath.row].age
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
