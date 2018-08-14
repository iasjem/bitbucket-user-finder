//
//  User.swift
//  Bitbucket User Finder
//
//  Created by Jemimah Beryl M. Sai on 13/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import ObjectMapper

class User: Mappable {
    var username: String?
    var displayName: String?
    var links: Link?
    
    required init?(map: Map) {  }
    
    func mapping(map: Map) {
        username <- map["username"]
        displayName <- map["display_name"]
        links <- map["links"]
    }
}
