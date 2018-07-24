//
//  ContactsTableViewCell.swift
//  FSCAl
//
//  Created by Admin on 23/07/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
     @IBOutlet weak var codeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
