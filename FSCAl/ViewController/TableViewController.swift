//
//  TableViewController.swift
//  FSCAl
//
//  Created by Admin on 23/07/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import FirebaseAuth
@available(iOS 10.0, *)
class TableViewController: UITableViewController {
    var refArtists: DatabaseReference!
    var artistList = [ArtistModel]()
    var searchedList = [ArtistModel]()
    var contacts: [NSManagedObject] = []
    @IBOutlet weak var searchBar: UISearchBar!
    var tableArray =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingData ()
        callingApi()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewControllerTableViewCell", for: indexPath) as! ViewControllerTableViewCell
        let candy = artistList[indexPath.row]
        cell.names.text = candy.name
        cell.message.text = candy.emailId
        if let myValue = candy.imageUrl as String?  {
            if myValue.isEmpty {
                let data = UIImagePNGRepresentation(UIImage(named: "Profile")!)
                let decodedimage:UIImage = UIImage(data: data!)!
                cell.profileImage.image = decodedimage
            } else {
                let dataDecoded:NSData = NSData(base64Encoded: myValue, options: NSData.Base64DecodingOptions(rawValue: 0))!
                let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                cell.profileImage.image = decodedimage
                
            }
        }
        
        
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.height/2
        cell.profileImage.layer.masksToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "FBViewController") as! FBViewController
        viewcontroller.hero = artistList[indexPath.row]
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
    }
    /*
     "artistName": textFieldName.text! as String,
     "artistPassword": textFieldPassword.text! as String,
     "artistImageUrl": convertedUrl,
     "artistEmailId": textFieldEmail.text! as String,
     "artistphoneNumber": textFieldPhoneNumber.text! as String,
     "artistCountryCode": codeBtn.currentTitle
     */
    
    func fetchingData (){
        refArtists = Database.database().reference().child("artists");
        //observing the data changes
        refArtists.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.artistList.removeAll()
                //iterating through all the values
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let artistObject = artists.value as? [String: AnyObject]
                    let artistName  = artistObject?["artistName"]
                    let artistId  = artistObject?["id"]
                    let artistEmailId = artistObject?["artistEmailId"]
                    let artistimageUrl = artistObject?["artistImageUrl"]
                    let artistCountryCode = artistObject?["artistCountryCode"]
                    let artistLastName = artistObject?["artistLastName"]
                    let artistphoneNumber = artistObject?["artistphoneNumber"]
                    //creating artist object with model and fetched values
                    let artist = ArtistModel(id: artistId as! String?, name: artistName as! String?, emailId: artistEmailId as! String?, imageUrl: artistimageUrl as? String,countryCode:artistCountryCode as? String, lastname: artistLastName as? String, phoneNumber: artistphoneNumber as? String)
                    //appending it to list
                    self.artistList.append(artist)
                }
                DispatchQueue.main.async {
                    self.searchedList = self.artistList
                    self.tableView.reloadData()
                }
                
            }
        })
        
    }
    
    
    @IBAction func signOutAction(_ sender: Any) {
        try! Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "LoggedIn")
        UserDefaults.standard.synchronize()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
            self.present(vc, animated: false, completion: nil)
        }
    }
}
@available(iOS 10.0, *)
extension TableViewController: UISearchBarDelegate,UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange text: String) {
        if (text == "") {
            artistList = searchedList
            tableView.reloadData()
        } else {
            searchThroughdata()
        }
    }
    func searchThroughdata() {
        artistList = searchedList.filter { ($0.name?.lowercased().contains(searchBar.text!.lowercased()))! }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        artistList = searchedList
        tableView.reloadData()
    }
    func callingApi () {
        let query = "https://restcountries.eu/rest/v1/all"
        
        APIService.callTheGetApi(url: query) { (result) in
            guard result.count > 0 else { return  }
            for i in 0..<result.count {
                let dicts = result[i]
                let name = dicts["name"]
                if let array = dicts["callingCodes"] as? [AnyObject] {
                    for name in array{
                        self.tableArray = name as! String
                    }
                }
                CoreData.saveNonImageContacts(name: name as! String, code: self.tableArray , entityName: "Contacts", firstObject: "countryCode", secondObject: "countryName")
            }
            DispatchQueue.main.async {
                self.contacts = CoreData.fetchDetailsFormDb(entityName:"Contacts")
                
            }
        }
    }
}


