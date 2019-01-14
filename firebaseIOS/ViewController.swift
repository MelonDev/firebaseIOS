//
//  ViewController.swift
//  firebaseIOS
//
//  Created by Android  on 6/8/2561 BE.
//  Copyright © 2561 Android . All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var myArray = [""]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "farmer_cell") as! UITableViewCell
        myCell.textLabel?.text = myArray[indexPath.row]
        return myCell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = "รายชื่อฟาร์ม"
        
        let ref = Database.database().reference().child("ข้อมูล")
        ref.observe(.value, with: {(snapshot) in
            //var i = 0
            for child in snapshot.children {
                let snap = child as? DataSnapshot
                print(snap?.key as Any)
            }
            
            
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

