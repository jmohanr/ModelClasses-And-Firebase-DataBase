//
//  LogInViewController.swift
//  MyApp
//
//  Created by Admin on 09/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var welcomeNoteLbl: UILabel!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var bgroundImg: UIImageView!
   
    var myString:String = "Welcome to My world"
    var newString:String = "Have More Fun AsMuchAs"
    var myMutableString = NSMutableAttributedString()
    var newMutableString = NSMutableAttributedString()
    var countdown = Double ()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var dict:[String:Any] = ["1":90,"2":21,"3":31]
  
        for i in 1..<dict.count{
            print(dict[String(i)] as Any)
        }
            self.hideKeyboard()
        signBtn.layer.cornerRadius = signBtn.frame.size.height/2
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        var _ = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    
    }

    
    @objc func keyboardWillShow(notification: NSNotification) {
    if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 100
        }
    }
}

@objc func keyboardWillHide(notification: NSNotification) {
    if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 100
        }
    }
 }


@objc func updateCounter() {
    
    if countdown > 0 {
        countdown -= 1
        newMutableString = NSMutableAttributedString(string: newString, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 18.0) as Any])
        newMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location:0,length:5))
        newMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: NSRange(location:13,length:9))
        welcomeNoteLbl.attributedText = newMutableString
    } else {
        countdown = 3
        myMutableString = NSMutableAttributedString(string: myString, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 18.0) as Any])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location:0,length:7))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: NSRange(location:13,length:6))
        welcomeNoteLbl.attributedText = myMutableString
    }
 }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
    }
    
    
    @IBAction func newUserRegesteraction(_ sender: Any) {
       
    }
    
    
    @IBAction func logInAction(_ sender: Any) {
        if self.userText.text == "" || self.passwordText.text == "" {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.userText.text!, password: self.passwordText.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                    let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController")
                    appDelegate.window?.rootViewController = initialViewController
                    UserDefaults.standard.set("true", forKey: "LoggedIn")
                    UserDefaults.standard.synchronize()
                    appDelegate.window?.makeKeyAndVisible()
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        //        if (userText.text?.isEmpty)! || (passwordText.text?.isEmpty)! {
        //            print("fill with correct details")
        //        } else {
        //            if isValidEmail(testStr: userText.text!){
        //
        //            } else{
        //                 print("fill with correct details")
        //            }
        //
        //        }
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
}
extension LogInViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(LogInViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
