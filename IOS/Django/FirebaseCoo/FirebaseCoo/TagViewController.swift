//
//  TagViewController.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/11.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
import Firebase
class TagViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension TagViewController : UISearchBarDelegate ,UITableViewDelegate , UITableViewDataSource {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let date = Date()
        UserManager.shared.ref.child("tag").child(searchBar.text!).queryOrdered(byChild: "date").queryStarting(atValue: date.timeIntervalSince1970 - 500000).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print("okok")

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
    }
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
