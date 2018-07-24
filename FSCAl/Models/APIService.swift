//
//  APIservice.swift
//  CoreDataTutorialPart1Final
//
//  Created by James Rochabrun on 3/2/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class APIService: NSObject {

    /// CALLING THE Get METHOD API
    static func callTheGetApi(url:String,completion: @escaping ([[String:AnyObject]])->() ) {
        guard let url = URL(string: url) else { return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return  }
            guard let data = data else { return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String:AnyObject]] {
                    
                    DispatchQueue.main.async {
                        completion(json )
                    }
                }
            }
        catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
   /// CALLING THE POST METHOD API
    
   static func callThePostApi(url:String,params: [String: AnyObject],completion: @escaping ([String: AnyObject])->() ) {
        guard let url = URL(string: url) else { return}
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
       request.setValue("token", forHTTPHeaderField: "QpwL5tke4Pnpja7X")
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return  }
            guard let data = data else { return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    
                    DispatchQueue.main.async {
                        completion(json)
                    }
                }
            }
            catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
            }.resume()
    }
    
    
}
    



