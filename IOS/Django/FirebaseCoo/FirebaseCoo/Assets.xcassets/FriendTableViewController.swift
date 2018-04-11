//
//  FriendTableViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
struct Friend {
    var name : String
    var email : String
    var uid : String
}
//YES NOTYET REJECT
class FriendTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var selectedUID = ""
    var friends = [Friend]()
    var unCheckFriends = [Friend]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getFriends("YES")
        getFriends("SENDING")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFriends(_ status : String) {

        let date = Date()
         UserManager.shared.ref.child("users").child(UserManager.shared.uid).child("friend").queryOrderedByValue().queryEqual(toValue: status).observe(.value, with: { (snapshot) in
            // Get user value
            
            
            if let value = snapshot.value as? NSDictionary {
                if status == "YES" {
                    self.friends.removeAll()
                }else if status == "SENDING"{
                    self.unCheckFriends.removeAll()
                }
                let myFriendUID = value.allKeys as! [String]
                print(myFriendUID)
                for key in myFriendUID {
                    UserManager.shared.ref.child("users").child(key).observe(.value, with: { (snap) in
                        guard let friendValue = snap.value as? NSDictionary else{
                            return
                        }
                        guard let email = friendValue["email"] as? String else{
                            return
                        }
                        let name = friendValue["name"] as! String
                        let friend = Friend(name: name, email: email, uid: key)
                        switch status {
                        case "YES":
                            self.friends.append(friend)
                            break
                        case "SENDING":
                            self.unCheckFriends.append(friend)
                            break
                        default:
                            break
                        }
                        self.tableView.reloadData()

                    })
                }
               
            }
            
            print("NOFriend")
        })
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if let desVC =  segue.destination as? FriendArticleViewController {
            
            desVC.uid = selectedUID
        }
     }
    
    
}
extension FriendTableViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0{
            cell.textLabel?.text = friends[indexPath.row].email
        }else{
            cell.textLabel?.text = unCheckFriends[indexPath.row].email
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "MY FRIENDS"
        }else{
            return "NOT YET"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return friends.count
        }else{
            return unCheckFriends.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
           selectedUID = friends[indexPath.row].uid
            self.performSegue(withIdentifier: "FriendArticleSegue", sender: self)
        }
    }
}
