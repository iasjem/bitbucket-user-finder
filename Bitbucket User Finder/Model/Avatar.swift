//
//  Avatar.swift
//  Bitbucket User Finder
//
//  Created by Jemimah Beryl M. Sai on 14/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import ObjectMapper

class Avatar: Mappable {
    var href: String?
    
    required init?(map: Map) {  }
    
    func mapping(map: Map) {
        href <- map["href"]
    }
}
