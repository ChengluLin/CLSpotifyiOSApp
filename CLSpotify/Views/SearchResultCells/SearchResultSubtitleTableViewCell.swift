//
//  File.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/5/3.
//

import UIKit
import SDWebImage


class SearchResultSubtitleTableViewCell: UITableViewCell {
    static let identfier = "SearchResultSubtitleTableViewCell"
    
    private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.addSubview(subtitleLabel)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 10
        iconImageView.frame = CGRect(x: 10,
                                     y: (contentView.height-imageSize)/2,
                                     width: imageSize,
                                     height: imageSize)
//        iconImageView.layer.cornerRadius = imageSize/2
//        iconImageView.layer.masksToBounds = true
        let labelHeight = contentView.height/2
        label.frame = CGRect(
            x: iconImageView.right+10,
            y: 0, width: contentView.width-iconImageView.right-15,
            height: contentView.height
        )
        subtitleLabel.frame = CGRect(
            x: iconImageView.right+20,
            y: label.bottom,
            width: contentView.width-iconImageView.right-15,
            height: labelHeight
        )
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subtitleLabel.text = nil
    }
    
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }

}

