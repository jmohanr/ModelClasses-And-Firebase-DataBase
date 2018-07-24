//
//  ViewControllerTableViewCell.swift
//  FSCAl
//
//  Created by Admin on 23/07/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
 @IBOutlet weak var message: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var names: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
