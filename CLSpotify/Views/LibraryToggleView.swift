//
//  LibraryToggleView.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/5/11.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libaryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libaryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)

}

class LibraryToggleView: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    weak var delegate: LibraryToggleViewDelegate?
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Alsbums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc private func didTapPlaylists() {
        self.state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libaryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        self.state = .album
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libaryToggleViewDidTapAlbums(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
        albumsButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 45)
        layoutIndicator()

    }
    
    func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(
                x: 0,
                y: playlistButton.bottom,
                width: 100,
                height: 3
            )
        case .album:
            indicatorView.frame = CGRect(
                x: 100,
                y: playlistButton.bottom,
                width: 100,
                height: 3
            )
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        
    }
    
}
