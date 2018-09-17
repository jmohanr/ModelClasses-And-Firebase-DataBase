//
//  SplashViewController.swift
//  MyApp
//
//  Created by Admin on 23/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((UserDefaults.standard.object(forKey: "LoggedIn")) != nil) {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController")
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
            
        } else {
            if (UserDefaults.standard.object(forKey: "walkthroughPresented") != nil) {
                self.performSegue(withIdentifier: "logIn", sender: nil)
            } else {
                self.performSegue(withIdentifier: "pageController", sender: nil)
            }
        }
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
