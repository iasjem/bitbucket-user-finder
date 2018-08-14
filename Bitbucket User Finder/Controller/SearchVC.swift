//
//  SearchVC.swift
//  Bitbucket User Finder
//
//  Created by Jemimah Beryl M. Sai on 13/08/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit

// MARK: SearchUserDelegate - protocol

protocol SearchUserDelegate: class {
    func searchQuery(query: String)
}

class SearchVC: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: Initializers
    
    weak var searchUserDelegate: SearchUserDelegate?
    var username: String = ""
    
    // MARK: View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: IBActions
    
    @IBAction func dismissModalView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UISearchBarDelegate

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        username = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchUserDelegate?.searchQuery(query: username)
        dismissModalView()
    }
}
