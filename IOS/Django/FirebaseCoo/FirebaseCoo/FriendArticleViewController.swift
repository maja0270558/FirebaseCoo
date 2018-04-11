//
//  FriendArticleViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/11.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit

class FriendArticleViewController: UIViewController {
    var posts = [Post]()
    var uid = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        UserManager.shared.ref.child("articles").queryOrdered(byChild: "uid").queryEqual(toValue: uid).observe(.value, with: { (snapshot) in
            // Get user value
            if  let value = snapshot.value as? NSDictionary {
                self.posts.removeAll()
                let keys = value.allKeys as! [String]
                print(keys)
                for key in keys {
                    if let trueValue = value[key] as? NSDictionary{
                        let myPost = Post(title: trueValue["title"] as! String, content: trueValue["content"] as! String)
                        self.posts.append(myPost)
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
extension FriendArticleViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = posts[indexPath.row].content
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
