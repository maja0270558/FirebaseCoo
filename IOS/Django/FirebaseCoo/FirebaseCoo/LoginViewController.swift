//
//  LoginViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
   
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: "hello1@gmail.com", password: "123456") { (user, error) in
            if error != nil {
                
            }else{
                print("login")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirebaseTabBar")
                UserManager.shared.uid = (user?.uid)!
                self.present(vc!, animated: true, completion: {
                    
                })
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
