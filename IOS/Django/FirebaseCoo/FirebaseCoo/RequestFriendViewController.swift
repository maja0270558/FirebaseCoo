//
//  RequestFriendViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit

class RequestFriendViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBAction func requestFriend(_ sender: Any) {
        if email.text! != "" {
            UserManager.shared.ref.child("users").queryOrdered(byChild: "email").queryEqual(toValue: email.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let value = snapshot.value as? NSDictionary {
                    let keys = value.allKeys as! [String]
                    let uid = keys[0]
                    UserManager.shared.ref.child("users").child(UserManager.shared.uid).child("friend").child(uid).setValue("SENDING")
                    UserManager.shared.ref.child("users").child(uid).child("friend").child(UserManager.shared.uid).setValue("UNCHECK")
                }
                
                
            })
        }
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
