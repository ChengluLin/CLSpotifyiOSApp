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
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2,
                leading: 7,
                bottom: 2,
                trailing: 7
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/2),
                    heightDimension: .absolute(150)),
                repeatingSubitem: item,
                count: 2)
            
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 0,
                bottom: 10,
                trailing: 0
            )
            
            return NSCollectionLayoutSection(group: group)
        }))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
        APICaller.shared.getCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    let first = model.first!
                    APICaller.shared.getCategoryPlaylists(category: first) { resupt in
                        
                    }
                case .failure(let error):
                    break
                }
            }
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: "Rock")
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}
