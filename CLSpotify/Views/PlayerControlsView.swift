//
//  PlayerControlsView.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/5/6.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapNextButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView)
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)

}

enum Playtype {
    case single
    case many
}

struct PlayerControlsViewModel {
    let title: String?
    let subtitle: String?
    let type: Playtype?
}

final class PlayerControlsView: UIView {
    
    private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "This is my song"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "subtitleLabel"

        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(playPauseButton)
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)

        clipsToBounds = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        print("valeeee", value)
        delegate?.playerControlsView(self, didSlideSlider: value)
    }
    
    @objc private func didTapBack() {
        delegate?.playerControlsViewDidTapBackwardsButton(self)
    }
    
    @objc private func didTapNext() {
        delegate?.playerControlsViewDidTapNextButton(self)
    }
    
    @objc private func didTapPlayPause() {
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPause(self)
        
        // Update icon
        let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        playPauseButton.setImage(isPlaying ? pause : play , for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)

        let buttonSize: CGFloat = 60
        
        playPauseButton.frame = CGRect(x: (width - buttonSize)/2, y: subtitleLabel.bottom + 30, width: buttonSize, height: buttonSize)
        
        backButton.frame = CGRect(x: playPauseButton.left-80-buttonSize, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        
        nextButton.frame = CGRect(x: playPauseButton.right+80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        
        volumeSlider.frame = CGRect(x: 10, y: playPauseButton.bottom+20, width: width-20, height: 44)
        
        
        
    }
    
    func configure(with viewModel: PlayerControlsViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        if viewModel.type == .single {
            self.backButton.isHidden = true
            self.nextButton.isHidden = true
        } else {
            self.backButton.isHidden = false
            self.nextButton.isHidden = false
        }
    }
}
