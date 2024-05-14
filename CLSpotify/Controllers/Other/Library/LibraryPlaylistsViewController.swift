//
//  LibraryPlaylistsViewController.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/5/11.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    var playlists = [Playlist]()
    
    private let noPlaylistsView = ActionLabelView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        noPlaylistsView.configure(with: ActionLabelViewModel(text: "You don't have any playlists yet", actionTitle: "Create"))
        
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            // Show label\
            noPlaylistsView.isHidden = false
        }
        else {
            // Show tabel
        }
    }
    
}
