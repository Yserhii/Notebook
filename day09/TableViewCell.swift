//
//  TableViewCell.swift
//  day09
//
//  Created by Yolankyi SERHII on 7/6/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var createDate: UILabel!
    @IBOutlet weak var modifDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
