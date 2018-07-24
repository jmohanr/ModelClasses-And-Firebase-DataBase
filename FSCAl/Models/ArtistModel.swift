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
    var genre: String?
    var imageUrl:String?
    var countryCode:String?
    
    init(id: String?, name: String?, genre: String?,imageUrl:String?,countryCode:String?){
        self.id = id
        self.name = name
        self.genre = genre
        self.imageUrl = imageUrl
        self.countryCode = countryCode
}
}
