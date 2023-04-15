//
//  ScreenshotViewerView.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import UIKit

class ScreenshotViewerView: UIView {
    
    private enum Constants {
        static var safeAreaInsets: UIEdgeInsets? {
           return UIApplication.shared.windows.first{$0.isKeyWindow }?.safeAreaInsets
        }
        
        static let spacing: CGFloat = sideInset*2
        static let itemWidth: CGFloat = UIScreen.main.bounds.width - 2*sideInset
        static let sideInset: CGFloat = 15
        static var itemHeight: CGFloat = {
            UIScreen.main.bounds.height - bottomInset - topInset
        }()
        static var topInset: CGFloat = {
            guard let safeAreaInsets = safeAreaInsets else { return 0 }
            return safeAreaInsets.top + sideInset*2
        }()
        static var bottomInset: CGFloat = {
            guard let safeAreaInsets = safeAreaInsets else { return 0 }
            print(safeAreaInsets.bottom)
            if safeAreaInsets.bottom == 0 {
                return sideInset*4
            } else {
                return safeAreaInsets.bottom + sideInset*3
            }
        }()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: Constants.itemWidth, height: Constants.itemHeight)
        layout.sectionInset = UIEdgeInsets(top: Constants.topInset, left: Constants.sideInset, bottom: Constants.bottomInset, right: Constants.sideInset)
        layout.minimumLineSpacing = Constants.spacing
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
