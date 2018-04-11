//
//  RequestTableViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit

class RequestTableViewController: UIViewController {
    var requests = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "RequestTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RequestCell")
        UserManager.shared.ref.child("users").child(UserManager.shared.uid).child("friend").queryOrderedByValue().queryEqual(toValue: "UNCHECK").observe( .value, with: { (snapshot) in
           self.requests.removeAll()
            if  let value = snapshot.value as? NSDictionary {
                let keys = value.allKeys as! [String]
                print("--------------")
                self.requests = keys
            }
            self.tableView.reloadData()

        })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension RequestTableViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as! RequestTableViewCell
        cell.name.text = requests[indexPath.row]
        cell.delegate = self
        cell.uid = requests[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension RequestTableViewController : RequestCellProtocol {
    func okPress(uid: String) {
        print("UID")
        UserManager.shared.ref.child("users").child(UserManager.shared.uid).child("friend").child(uid).setValue("YES")
        UserManager.shared.ref.child("users").child(uid).child("friend").child(UserManager.shared.uid).setValue("YES")
    }
    
    func noPress(uid: String) {
        requests.remove(at: requests.index(of: uid)!)
        UserManager.shared.ref.child("users").child(UserManager.shared.uid).child("friend").child(uid).removeValue()
        UserManager.shared.ref.child("users").child(uid).child("friend").child(UserManager.shared.uid).setValue("NO")
    }
}
