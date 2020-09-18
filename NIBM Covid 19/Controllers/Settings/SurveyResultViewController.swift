//
//  SurveyResultViewController.swift
//  NIBM Covid 19
//
//  Created by TM on 9/18/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit
import FirebaseDatabase


class SurveyResultViewController: UIViewController {
    
    var tableView = UITableView()
    var surveyResultArray = [SurveyResult]()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Survey Result"
        view.backgroundColor = UIColor.backgroundColor
        getNotification()


        // Do any additional setup after loading the view.
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
        
        tableView.register(SurveyResultCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    private func getNotification(){
        
        
        
        showUniversalLoadingView(true, loadingText: "Fetching Data..")
        
        Database.database().reference().child("users").observe(.value, with: { (snapshot) in
            
            self.surveyResultArray.removeAll()
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let dict = child.value as? [String : AnyObject] ?? [:]
                
                var q1 = "NO"
                var q2 = "NO"
                var q3 = "NO"
                var q4 = "NO"

                if Int(truncating: (dict["surveyOne"] as? NSNumber ?? 0)) > 0 {
                    q1 = "YES"
                }
                
                if Int(truncating: (dict["surveyTwo"] as? NSNumber ?? 0)) > 0 {
                    q2 = "YES"
                }
                
                if Int(truncating: (dict["surveyThree"] as? NSNumber ?? 0) ) > 0 {
                    q3 = "YES"
                }
                
                if Int(truncating: (dict["surveyFour"] as? NSNumber ?? 0)) > 0 {
                    q4 = "YES"
                }
                
                self.surveyResultArray.append(SurveyResult(name: dict["firstName"] as! String, q1: q1, q2: q2, q3: q3, q4: q4))

            }
            print(self.surveyResultArray)
            self.setTableView()
            self.tableView.reloadData()

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


extension SurveyResultViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SurveyResultCell else {fatalError("Unabel to create cell")}
    
        
        cell.nameLbl.text = surveyResultArray[indexPath.row].name
        cell.q1Text.text = surveyResultArray[indexPath.row].q1
        cell.q2Text.text = surveyResultArray[indexPath.row].q2
        cell.q3Text.text = surveyResultArray[indexPath.row].q3
        cell.q4Text.text = surveyResultArray[indexPath.row].q4
//        cell.textLbl.text = notificationArr[indexPath.row].text
//        cell.dateLbl.text = surveyResultArray[indexPath.row].created
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}
