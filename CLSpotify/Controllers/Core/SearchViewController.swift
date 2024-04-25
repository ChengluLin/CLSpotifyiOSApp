//
//  SearchViewController.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/3/30.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {

    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Songs, Artists, Albums"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController

    }
    
    //MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchController.searchBar.text,
        !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        // resultsController.update(with: results)
        print(query)
        // Perform search
        
        // APICaller
    }
}
