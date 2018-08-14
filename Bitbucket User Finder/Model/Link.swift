//
//  Link.swift
//  Bitbucket User Finder
//
//  Created by Jemimah Beryl M. Sai on 14/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import ObjectMapper

class Link: Mappable {
    var avatar: Avatar?
    var html: Html?
    
    required init?(map: Map) {  }
    
    func mapping(map: Map) {
        avatar <- map["avatar"]
        html <- map["html"]
    }
}
