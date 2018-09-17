//
//  ViewController.swift
//  FSCAl
//
//  Created by Admin on 27/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    /*
     import FSCalendar
}
,FSCalendarDelegate,FSCalendarDataSource {
    @IBOutlet weak var fsCalender: FSCalendar!
    var selectedDate = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
practice ()
       
    }
        fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    func  maximumDate(for calendar: FSCalendar) -> Date {
        return formatter.date(from: "30/12/2050")!
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate.append(formatter.string(from: date))
        print("am selected the date is  \(formatter.string(from: date))")
        print(selectedDate)
        for dates in selectedDate {
            print(dates)
        }
        for da in 0..<10{
            print(da)
        }
    }
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return gregorian.isDateInToday(date) ? "今天" : nil
    }
    
    func practice () {
        var name = 0
        
        let myarray = ["1","2","3","4"]
        var daysDictionary = [1 : "SunDay",2 : "MonDay",3 : "TuesDay",4 : "WednesDay",5 : "ThursDay",6 : "FriDay",7 : "SaturDay"]
        for _ in myarray {
        }
        for i in 0...myarray.count {
         name += i
        }
        for (_,_) in daysDictionary {
        }
        for slide in stride(from: 0, to: daysDictionary.count, by:5) {
           print(slide)
        }
   
    daysDictionary.updateValue("hi", forKey: 1)
        daysDictionary.removeValue(forKey: 6)
     print(daysDictionary)
        
        for value in daysDictionary.values{
            print(value)
        }
        for keys in daysDictionary.keys {
               print(keys)
        }

        let query = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=birds&nojsoncallback=1#"
        
        APIService.callTheGetApi(url: query) { (result) in
           print("my api result is\(result)")
        }

        let params = ["email": "peter@klaven",
                      "password": "cityslicka"]
      
        APIService.callThePostApi(url: "https://reqres.in/api/login", params: params as [String : AnyObject]) { (result) in
            print(result)
        }
    }
   
    
*/

}

