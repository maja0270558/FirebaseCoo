//
//  ViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    lazy var ref = Database.database().reference()
    var uid : String?
    @IBAction func get(_ sender: Any) {
        
//        let query = ref.queryOrdered(byChild: "uid").queryEqual(toValue: uid)
//        query.observeSingleEvent(of: .value, with: { (snapshot) in
//            for childSnapshot in snapshot.children {
//                print(childSnapshot)
//            }
//        })
        
        
//        let ref = FIRDatabase.database().reference().child("thoughts").queryOrdered(byChild: "createdAt").queryEqual(toValue : "Today")
    
        ref.child("users").child("F7pv1T6QdoQ5Qg3k3NFmk8t0t0j1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary {
                if let friends = value["friend"] as? NSDictionary{
                    let keys = friends.allKeys as! [String]
                    let value = friends.allValues as! [Bool]
                    print(value)
                }else{
                    print("noFriend")
                }
            }
            
            print("  ")
        })
    }
    @IBAction func post(_ sender: UIButton) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            ref.child("articles").childByAutoId().setValue(
                [
                    "title": "thirdPost" ,
                    "content" : "insterLove3ijifjeifje",
                    "uid" : uid ,
                    "tag" : ["Love2" ,"Instergram134"],
                    "date" : 5278
                ]
            )
            // ...
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //set data
        
        Auth.auth().signIn(withEmail: "hello1@gmail.com", password: "123456") { (user, error) in
            if error != nil {
                
            }else{
                print("login")
                self.uid = user?.uid
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        Auth.auth().createUser(withEmail: "hello1@gmail.com", password: "123456") { (user, createError) in
            if createError != nil {
                
            }else{
                print("OK")
                if let user = Auth.auth().currentUser {
                    let uid = user.uid
                    let email = user.email
                    let photoURL = user.photoURL
                    self.ref.child("users").child(uid).setValue(
                        [
                            "name": "Django" ,
                            "email" : email! ,
                            "friends" : [String:Bool]()
                        ]
                    )
                }
            }
        }
        
        //        if Auth.auth().currentUser != nil {
        //            if let user = Auth.auth().currentUser {
        //                // The user's ID, unique to the Firebase project.
        //                // Do NOT use this value to authenticate with your backend server,
        //                // if you have one. Use getTokenWithCompletion:completion: instead.
        //                let uid = user.uid
        //                let email = user.email
        //                let photoURL = user.photoURL
        //                self.ref.child("users").child(uid).setValue(["username": "django" , "email" : email!])
        //                // ...
        //            }
        //            // User is signed in.
        //            // ...
        //        } else {
        //            // No user is signed in.
        //
        //            // ...
        //        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

