//
//  FireBaseViewController.swift
//  FSCAl
//
//  Created by Admin on 13/08/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import  Firebase

class FireBaseViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var takePicButton: UIButton!
    @IBOutlet weak var downloadPicButton: UIButton!
    @IBOutlet weak var urlTextView: UITextField!
    
    // [START configurestorage]
    lazy var storage = Storage.storage()
    // [END configurestorage]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadPicButton.isEnabled = true
        // [START storageauth]
        // Using Cloud Storage for Firebase requires the user be authenticated. Here we are using
        // anonymous authentication.
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously(completion: { (authResult, error) in
                if let error = error {
                    self.urlTextView.text = error.localizedDescription
                    self.takePicButton.isEnabled = false
                } else {
                    self.urlTextView.text = ""
                    self.takePicButton.isEnabled = true
                }
            })
        }
        // [END storageauth]
    }
    
    // MARK: - Image Picker
    
    @IBAction func didTapTakePicture(_: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion:nil)
        
        urlTextView.text = "Beginning Upload"
        // if it's a photo from the library, not an image from the camera

            guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
            let imagePath = Auth.auth().currentUser!.uid +
            "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            let storageRef = self.storage.reference(withPath: imagePath)
            storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error uploading: \(error)")
                    self.urlTextView.text = "Upload Failed"
                    return
                }
                self.uploadSuccess(storageRef, storagePath: imagePath)
            }
        }
    
    
    func uploadSuccess(_ storageRef: StorageReference, storagePath: String) {
        print("Upload Succeeded!")
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error getting download URL: \(error)")
                self.urlTextView.text = "Can't get download URL"
                return
            }
            self.urlTextView.text = url?.absoluteString ?? ""
            UserDefaults.standard.set(storagePath, forKey: "storagePath")
            UserDefaults.standard.synchronize()
            self.downloadPicButton.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}
