//
//  DetailTableViewController.swift
//  firebaseIOS
//
//  Created by Android  on 16/8/2561 BE.
//  Copyright © 2561 Android . All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    func configureView() {
        navigationItem.title = farmer.name
    }
    
    var farmer = Farmer(name: "",key :""){
        didSet {
            // Update the view.
            print(farmer.name)
            configureView()
        }
    }

}
