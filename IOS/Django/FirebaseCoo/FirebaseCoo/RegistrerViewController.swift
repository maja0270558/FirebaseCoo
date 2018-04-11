//
//  RegistrerViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class RegistrerViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    lazy var ref = Database.database().reference()

    @IBAction func register(_ sender: Any){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, createError) in
            if createError != nil {
                
            }else{
                print("OK")
                if let user = Auth.auth().currentUser {
                    let uid = user.uid
                    let email = user.email
                    let n = Int(arc4random_uniform(100))
                    self.ref.child("users").child(uid).setValue(
                        [
                            "name": "User\(n)" ,
                            "email" : email! ,
                            "friends" : [String:Bool]()
                        ]
                    )
                }
            }
        }
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
