//
//  ArtistModel.swift
//  FSCAl
//
//  Created by Admin on 23/07/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class ArtistModel {
    
    var id: String?
    var name: String?
    var lastname:String?
    var emailId: String?
    var imageUrl:String?
    var countryCode:String?
    var phoneNumber:String?
    
    
    init(id: String?, name: String?, emailId: String?,imageUrl:String?,countryCode:String?,lastname:String?,phoneNumber:String?){
        self.id = id
        self.name = name
        self.emailId = emailId
        self.imageUrl = imageUrl
        self.countryCode = countryCode
        self.lastname = lastname
        self.phoneNumber = phoneNumber
    }
}
