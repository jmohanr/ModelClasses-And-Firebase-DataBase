//
//  FBViewController.swift
//  FSCAl
//
//  Created by Admin on 23/07/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Firebase
import  CoreData

class FBViewController: UIViewController{
    var contacts: [NSManagedObject] = []
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
      @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var pickerView: UIPickerView!
    var refArtists: DatabaseReference!
    var convertedUrl = ""
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var labeltxt: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
     var hero:ArtistModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldName.text = hero?.name
         toolBar.isHidden = true
          pickerView.isHidden = true
         self.contacts = CoreData.fetchDetailsFormDb(entityName:"Contacts")
         refArtists = Database.database().reference().child("artists");
        let tapProfilePic = UITapGestureRecognizer(target: self, action: #selector(tapProfilePicFunction))
        profileImage.addGestureRecognizer(tapProfilePic)
        profileImage.isUserInteractionEnabled = true
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        self.hideKeyboard()
        saveBtn.layer.cornerRadius = 5.0
        NotificationCenter.default.addObserver(self, selector: #selector(FBViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FBViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 150
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 150
            }
        }
    }
    
    func addArtist(){
        //generating a new key inside artists node and also getting the generated key
        let key = refArtists.childByAutoId().key
        //creating artist with the given values
        let artist = ["id":key,
                      "artistName": textFieldName.text! as String,
                      "artistPassword": textFieldPassword.text! as String,
                      "artistImageUrl": convertedUrl,
                       "artistEmailId": textFieldEmail.text! as String,
                      "artistphoneNumber": textFieldPhoneNumber.text! as String,
                      "artistCountryCode": codeBtn.currentTitle
            ] 
        
        //adding the artist inside the generated unique key
        refArtists.child(key).setValue(artist)
        //displaying message
        labeltxt.text = "Artist Added"
    }
    
    func updateArtist(){
        //creating artist with the new given values
        let key = refArtists.childByAutoId().key
        let artist = ["id":key,
                      "artistName": textFieldName.text! as String,
                      "artistPassword": textFieldPassword.text! as String,
                      "artistImageUrl": convertedUrl,
                      "artistEmailId": textFieldEmail.text! as String,
                      "artistphoneNumber": textFieldPhoneNumber.text! as String,
                      "artistCountryCode": codeBtn.currentTitle
        ]
        
        //updating the artist using the key of the artist
        refArtists.child(key).setValue(artist)
        
        //displaying message
        labeltxt.text = "Artist Updated"
    }
    
    @IBAction func buttonRegister(sender: UIButton) {
        if (textFieldName.text?.isEmpty)! || (textFieldEmail.text?.isEmpty)!||(textFieldPassword.text?.isEmpty)! || (textFieldPhoneNumber.text?.isEmpty)! {
            labeltxt.text = "Please enter all details"
        }
        else{
            if isValidEmail(testStr: textFieldEmail.text!) {
                if (textFieldName.text?.isEmpty)! {
                    updateArtist()
                } else {
                     addArtist()
                }
               
            }
            else {
                labeltxt.text = "Please enter Preoper EmailId"
            }
            
        }
        
    }
    @IBAction func buttonforCountryCodes(sender: UIButton) {
        pickerView.isHidden = false
        toolBar.isHidden = false
    }
   
}


extension FBViewController:UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @objc func tapProfilePicFunction(sender:UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction!) in
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (action:UIAlertAction!) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }        }
        
        
        let photo = UIAlertAction(title: "PhotoLibrary", style: .default) { (action:UIAlertAction!) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        alertController.addAction(photo)
        alertController.addAction(camera)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion:nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    var selectedImage: UIImage?
    
    selectedImage = info["UIImagePickerControllerEditedImage"]   as? UIImage
        let data = UIImagePNGRepresentation(selectedImage!)
        convertedUrl = (data?.base64EncodedString(options: NSData.Base64EncodingOptions()))!
    self.profileImage.image =  selectedImage
      
    self.dismiss(animated: true, completion: nil)
    
    }
}
extension FBViewController:UITextFieldDelegate {
    
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
            action: #selector(FBViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        var newString = NSString()
        if textField == textFieldPhoneNumber {
            let currentString: NSString = textField.text! as NSString
           newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        }
       
        return newString.length <= maxLength
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
extension FBViewController:UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return contacts.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let kundObj = self.contacts[row] as! Contacts
            return "\(kundObj.value(forKey: "countryName") as! String)     \(kundObj.value(forKey: "countryCode") as! String)"
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         let kundObj = self.contacts[row] as! Contacts
      codeBtn.setTitle((kundObj.value(forKey: "countryName") as! String), for: .normal)
        
}
    @IBAction func cancelAction(sender: UIBarButtonItem){
        codeBtn.setTitle("91", for: .normal)
        toolBar.isHidden = true
        pickerView.isHidden = true
    }
    @IBAction func doneAction(sender: UIBarButtonItem){
        toolBar.isHidden = true
        pickerView.isHidden = true
    }
}
