//
//  ThirdViewController.swift
//  MyApp
//
//  Created by Admin on 09/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    var pageIndex :Int = 0
    var lblTitle:String!
    var imgName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = UIImage(named: imgName)
        lbl.text = lblTitle
        
    }


}
