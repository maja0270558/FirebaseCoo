//
//  PostTableViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
struct Post {
    var title:String?
    var content:String?
}
class PostTableViewController: UIViewController {
    @IBAction func createPost(_ sender: UIBarButtonItem) {
    }
    @IBOutlet weak var tableView: UITableView!
    var post = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        UserManager.shared.ref.child("articles").queryOrdered(byChild: "uid").queryEqual(toValue: UserManager.shared.uid).observe(.value, with: { (snapshot) in
            // Get user value
            if  let value = snapshot.value as? NSDictionary {
                self.post.removeAll()
                let keys = value.allKeys as! [String]
                print(keys)
                for key in keys {
                    if let trueValue = value[key] as? NSDictionary{
                        let myPost = Post(title: trueValue["title"] as! String, content: trueValue["content"] as! String)
                        self.post.append(myPost)
                    }
                }
                self.tableView.reloadData()
            }
        })
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
extension PostTableViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = post[indexPath.row].content
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
