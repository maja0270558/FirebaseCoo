//
//  UserManager.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserManager{
    static let shared = UserManager()
    var uid = ""
    lazy var ref = Database.database().reference()
}
