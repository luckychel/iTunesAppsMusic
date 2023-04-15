//
//  ScreenshotCell.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 14.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    public static let reuseIdentifier = "screenshotCell"
    
    private lazy var screenshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(screenshotImageView)
        
        NSLayoutConstraint.activate([
            screenshotImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            screenshotImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            screenshotImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            screenshotImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with urlString: String) {
        let url = URL(string: urlString)
        screenshotImageView.kf.setImage(with: url)
    }
    

    override func prepareForReuse() {
        screenshotImageView.image = nil
    }
}
