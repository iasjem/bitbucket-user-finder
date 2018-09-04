//
//  UserService.swift
//  Bitbucket User Finder
//
//  Created by Jemimah Beryl M. Sai on 13/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireImage

class UserService {
    
    // MARK: Initializers
    
    static let instance = UserService()
    var user: UserDisplay?
    
    // MARK: API Services
    
    func retrieveData(username: String, completion: @escaping (_ completion: Bool) -> ()) {
        Alamofire.request("\(BASE_URL)\(username)").responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    guard let responseJSON = value as? [String: AnyObject] else { return }
                    guard let json = Mapper<User>().map(JSON: responseJSON) else { return }
                    guard let username = json.username else { return }
                    guard let displayName = json.displayName else { return }
                    guard let avatarURL = json.links?.avatar?.href else {  return  }
                    guard let htmlURL = json.links?.html?.href else {  return  }
                    self.user = UserDisplay(username: username, displayName: displayName, avatarURL: avatarURL, htmlURL: htmlURL)
                    completion(true)
                    print("sucessfully loaded data")
                case .failure(let error):
                    completion(false)
                    print("failed to retrieve data: \(error.localizedDescription)")
            }
        }
    }
    
    func retrieveAvatar(avatarURL: String, completion: @escaping (_ completion: Bool, _ avatarImage: Image) -> ()) {
        Alamofire.request(avatarURL).responseImage { (response) in
            switch response.result {
                case .success(let value):
                    completion(true, value)
                    print("sucessfully loaded image")
                case .failure(let error):
                    completion(false, UIImage())
                    print("failed to retrieve image: \(error.localizedDescription)")
            }
        }
    }
    
    func clearUserData() {
        user = nil
    }
}
