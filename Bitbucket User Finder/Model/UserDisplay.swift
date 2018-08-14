//
//  UserDisplay.swift
//  Bitbucket User Finder
//
//  Created by Jemimah Beryl M. Sai on 13/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

struct UserDisplay {
    private(set) var username: String
    private(set) var displayName: String
    private(set) var avatarURL: String
    private(set) var htmlURL: String
    
    init(username: String, displayName: String, avatarURL: String, htmlURL: String) {
        self.username = username
        self.displayName = displayName
        self.avatarURL = avatarURL
        self.htmlURL = htmlURL
    }
}
