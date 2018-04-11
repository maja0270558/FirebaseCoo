//
//  CreatePostViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
import Firebase

class CreatePostViewController: UIViewController {
    
    @IBAction func post(_ sender: UIButton) {
        let key = UserManager.shared.ref.child("articles").childByAutoId().key
        let time = ServerValue.timestamp()
        print(key)
        UserManager.shared.ref.child("articles").child(key).setValue(
            [
                "title": postTitle.text! ,
                "content" : content.text!,
                "uid" :  UserManager.shared.uid ,
                "tag" : tag.text!,
                "date" : time
            ]
        )
        UserManager.shared.ref.child("tag").child(tag.text!).child(key).setValue(
            [
                "title": postTitle.text! ,
                "content" : content.text!,
                "uid" :  UserManager.shared.uid ,
                "tag" : tag.text!,
                "date" : time
            ]
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var content: UITextField!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var tag: UITextField!
    
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
