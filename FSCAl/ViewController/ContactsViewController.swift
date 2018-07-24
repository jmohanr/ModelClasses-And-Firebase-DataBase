//
//  ContactsViewController.swift
//  FSCAl
//
//  Created by Admin on 23/07/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var contacts: [NSManagedObject] = []
    @IBOutlet weak var tableView: UITableView!
    var tableArray =  ""
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        callingApi()
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
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as? ContactsTableViewCell
        let contact = contacts[indexPath.row]
        cell?.nameLbl.text = (contact.value(forKey: "countryName") as! String)
         cell?.codeLbl.text = (contact.value(forKey: "countryCode") as! String)
        return cell!
    }

}
