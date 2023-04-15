//
//  AppDetailDescriptionView.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 14.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import UIKit

class AppDetailDescriptionView: UIView {
    private(set) lazy var whatsNewLabel: UILabel = {
        let label = UILabel()
        label.text = "What's New"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private(set) lazy var versionHistoryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font =  .systemFont(ofSize: 18)
        button.setTitle("Version History", for: .normal)
        
        return button
    }()
    
    private(set) lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [whatsNewLabel, versionHistoryButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering

        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        
        return label
    }()
    
    private(set) lazy var versionDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        
        return label
    }()
    
    private(set) lazy var versionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [versionLabel, versionDateLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering

        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private(set) lazy var releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        self.addSubview(titleStackView)
        self.addSubview(versionStackView)
        self.addSubview(releaseNotesLabel)
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            titleStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16.0),
            titleStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            titleStackView.heightAnchor.constraint(equalToConstant: 30.0),
            
            versionStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 5.0),
            versionStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16.0),
            versionStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            versionStackView.heightAnchor.constraint(equalToConstant: 30.0),
            
            releaseNotesLabel.topAnchor.constraint(equalTo: versionStackView.bottomAnchor, constant: 5.0),
            releaseNotesLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16.0),
            releaseNotesLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            releaseNotesLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func setReleaseNoteText(with text: String) {
        releaseNotesLabel.text = text
        releaseNotesLabel.setLineSpacing(lineSpacing: 5)
    }
}
