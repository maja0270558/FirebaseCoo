//
//  RequestTableViewCell.swift
//  FirebaseCoo
//
//  Created by 大容 林 on 2018/4/10.
//  Copyright © 2018年 DjangoCode. All rights reserved.
//

import UIKit
protocol RequestCellProtocol :class{
    func okPress(uid : String)
    func noPress(uid : String)
}

class RequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    weak var delegate :RequestCellProtocol?
    @IBAction func ok(_ sender: UIButton) {
        delegate?.okPress(uid: uid)
    }
    
    @IBAction func no(_ sender: UIButton) {
        delegate?.noPress(uid: uid)
    }
    var uid = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
