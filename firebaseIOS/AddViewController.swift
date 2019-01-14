//
//  AddViewController.swift
//  firebaseIOS
//
//  Created by Android on 12/1/2562 BE.
//  Copyright © 2562 Android . All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let cancelAction = UIBarButtonItem.init(title: "ยกเลิก", style: .plain, target: self, action: #selector(cancelTapped))
        cancelAction.tintColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        
        let confirmAction = UIBarButtonItem.init(title: "ยืนยัน", style: .done, target: self, action: #selector(confirmTapped))
        confirmAction.tintColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)

        

        //let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 41/255, green: 121/255, blue: 255/255, alpha: 1)
        
        
        
        
        self.navigationItem.leftBarButtonItem = cancelAction
        self.navigationItem.rightBarButtonItem = confirmAction
        self.navigationItem.title = "เพิ่มข้อมูลฟาร์ม"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        //self.navigationItem.leftBarButtonItem?.title = "แก้ไข"
        
    }
    
    @objc func cancelTapped(sender: AnyObject) {
       self.dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmTapped(sender: AnyObject) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)

    }
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
