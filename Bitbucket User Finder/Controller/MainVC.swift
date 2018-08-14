//
//  ViewController.swift
//  Bitbucket User Finder
//
//  Created by Jemimah Beryl M. Sai on 13/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLinkButton: UIButton!
    @IBOutlet weak var userDataView: UIStackView!
    @IBOutlet weak var loadingDataView: UIStackView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var connectionStatusLabel: UILabel!
    
    // MARK: Initializers
    
    var service = UserService.instance
    private var currentUser: String = "karllhughes"
    
    // MARK: View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData(from: currentUser)
    }
    
    // MARK: IBActions
    
    @IBAction func usernameLinkButtonWasPressed(_ sender: Any) {
        guard let htmlURL = service.user?.htmlURL else {  return  }
        UIApplication.shared.open(URL(string: htmlURL)!)
    }
    
    // MARK: API functions
    
    func retrieveData(from user: String) {
        dataIsLoading()
        service.retrieveData(username: user) { (success) in
            
            if success {
                self.dataWasLoaded(true)
                self.displayUserAvatar()
                self.setupUserDataView()
            } else {
                self.dataWasLoaded(false)
            }
        }
    }
    
    func displayUserAvatar() {
        guard let avatarURL = service.user?.avatarURL else {  return  }
        service.retrieveAvatar(avatarURL: avatarURL) { (success, url) in
            if success {
                self.userAvatar.image = url
            } else {
                self.userAvatar.image = UIImage()
            }
        }
    }
    
    // MARK: Setup
    
    func setupUserDataView() {
        guard let displayName = service.user?.displayName else { return }
        guard let username = service.user?.username else {  return  }
        displayNameLabel.text = displayName
        usernameLinkButton.setTitle("@\(username)", for: .normal)
    }
    
    // MARK: Helpers
    
    func dataIsLoading() {
        spinner.startAnimating()
        connectionStatusLabel.text = "Loading data"
        userDataView.isHidden = true
        loadingDataView.isHidden = false
    }
    
    func dataWasLoaded(_ status: Bool) {
        spinner.stopAnimating()
        if status == true {
            userDataView.isHidden = false
            loadingDataView.isHidden = true
        } else {
            userDataView.isHidden = true
            loadingDataView.isHidden = false
            connectionStatusLabel.text = "Loading failed. Please try again."
        }
    }
}

// MARK: SearchUserDelegate

extension MainVC: SearchUserDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            guard let searchVC = segue.destination as? SearchVC else { return }
            searchVC.searchUserDelegate = self
        }
    }
    
    func searchQuery(query: String) {
        var userFromQuery = query
        if query.isEmpty {
            userFromQuery = currentUser
        }
        currentUser = userFromQuery
        retrieveData(from: currentUser)
    }
}

