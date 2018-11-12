//
//  myTableViewCell.swift
//  Test
//
//  Created by Mikhail Zoline on 11/8/18.
//  Copyright © 2018 MZ. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    @IBOutlet var Description: UILabel!
    @IBOutlet var Product: UILabel!
    @IBOutlet var Category: UILabel!
    @IBOutlet var Weight: UILabel!
    @IBOutlet var Price: UILabel!
    @IBOutlet var OnSale: UILabel!
    @IBOutlet var SKU: UILabel!
    @IBOutlet var Icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
