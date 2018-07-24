//
//  SwipeVC.swift
//  FSCAl
//
//  Created by Admin on 03/07/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class SwipeVC: UIViewController {
    @IBOutlet var swipeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
swipeView.frame = CGRect(x: 0, y: self.view.frame.size.height-150, width: self.view.frame.size.width, height: 150)
        self.view.addSubview(swipeView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//   @objc func handlePangesture() {
//        swipeView.frame = CGRect(x: 0, y: self.view.frame.size.height-250, width: self.view.frame.size.width, height: 300)
//    swipeView.backgroundColor = UIColor.red
//    }
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x,
                                  y:view.center.y + translation.y)
            if swipeView.frame.height == 150 {
                swipeView.frame = CGRect(x: 0, y: 150, width: self.view.frame.size.width, height: 300)
            }
            else if swipeView.frame.height == view.frame.height/2 {
                swipeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
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
