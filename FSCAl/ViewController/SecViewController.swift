//
//  SecViewController.swift
//  FSCAl
//
//  Created by Admin on 28/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//
struct jsonData {
    var link:String!
    var tags:String!
}
import UIKit
import CoreData

class SecViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var heroes = [HeroStats]()
    var datas = [jsonData]()
    var contacts: [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       callingApi ()
        tableView.delegate = self
        tableView.dataSource = self
        contacts = CoreData.fetchDetailsFormDb(entityName: "Photo")

    }
    
    func callingApi () {
        let query = "https://jsonplaceholder.typicode.com/photos"
        APIService.callTheGetApi(url: query) { (result) in
            guard result.count > 0 else { return  }
            for i in 0..<result.count {
                let dicts = result[i]
                let url = dicts["url"]
                let tags = dicts["title"]
                CoreData.save(name: tags as! String, imageUrl: url as! String, entityName: "Photo", firstObject: "title", secondObject: "image")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
         let contact = contacts[indexPath.row]
        let urlString = (contact.value(forKey: "image") as! String)
        let url = URL(string: urlString)
        cell?.displayImage.downloadedFrom(url: url!)
        cell?.name.text = (contact.value(forKey: "title") as! String)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "SwipeVC") as! SwipeVC
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    
    
    func downloadJSON(completed: @escaping () -> (Void)) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("JSON Error")
                }
            }
            }.resume()
    }
}

