//
//  FarmerTableViewController.swift
//  firebaseIOS
//
//  Created by Android  on 6/8/2561 BE.
//  Copyright © 2561 Android . All rights reserved.
//

import UIKit
import FirebaseDatabase
//import FirebaseDatabase

class FarmerTableViewController: UITableViewController {
    
    var farm :[Farmer] = []
    var myArray :[String] = []
    
    var objects = [Any]()
    
    var data = [String():Array<Farmer>()]
    
    let searchController = UISearchController(searchResultsController: nil)
    var detailViewController: DetailViewController? = nil
    //var detailTableViewController: DetailTableViewController? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = ["รายชื่อ":farm]
        
        self.title = "รายชื่อฟาร์ม"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "แก้ไข"
    
        searchController.searchBar.setValue("ยกเลิก", forKey: "_cancelButtonText")
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "ค้นหาชื่อ.."
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        //var newItems: [String] = []
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
 /*
            detailTableViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailTableViewController
 */
        }

        let ref = Database.database().reference().child("ข้อมูล")
        ref.observe(.value, with: {(snapshot) in
            var i = 0
            self.data["รายชื่อ"] = []
            
            
        for child in snapshot.children {
            let snap = child as? DataSnapshot
            let id = snap?.key as! String
                        
            let refFarmer = ref.child(id).child("รายละเอียด").child("ชื่อฟาร์ม")
            refFarmer.observeSingleEvent(of: .value, with: {(snapshots) in
                let value = snapshots.value as! String
                let farmer :Farmer = Farmer(name: value, key: id)
                
                //self.farm.append(farmer)
                self.data["รายชื่อ"]?.append(farmer)
                self.tableView.reloadData()
                //print(i)
                if(i == snapshot.childrenCount - 1){
                    //print("TEST")

                }
                i+=1
                
            })
            
            
        }
        
        
       })
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("T")
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                //self.navigationController?.navigationBar.prefersLargeTitles = false
                
                //let object = objects[indexPath.row] as! NSDate
                //let obj = farm[indexPath.row]
                let obj = self.data["รายชื่อ"]![indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.farmer = obj
                //controller.title = obj.name
                //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
 
               /* let controller = (segue.destination as! UINavigationController).topViewController as! DetailTableViewController
                controller.farmer = obj
                controller.title = obj.name
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
             */
            }
        }
    }
    
   
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing,animated:animated)
        if(self.isEditing)
        {
            self.editButtonItem.title = "เรียบร้อย"
        }else
        {
            self.editButtonItem.title = "แก้ไข"
        }
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        //print("CLICK")
        //objects.insert(NSDate(), at: 0)
        //let indexPath = IndexPath(row: 0, section: 0)
        //tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return farm.count
        //self.data["รายชื่อ"] = []
        //return data["รายชื่อ"]!.count
        switch section {
        case 0:
            return data["รายชื่อ"]!.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "farmerCell") as! UITableViewCell
        //myCell.textLabel?.text = farm[indexPath.row].name
        myCell.textLabel?.text = self.data["รายชื่อ"]![indexPath.row].name
        let bgColorView = UIView()
        
        var color = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        bgColorView.backgroundColor = color
        myCell.selectedBackgroundView = bgColorView
        //myCell.textLabel?.textColor = UIColor.white
        myCell.textLabel?.highlightedTextColor = UIColor.white
    
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func firstS() {
        self.tableView.selectRow(at:  IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)

    }
    


}
