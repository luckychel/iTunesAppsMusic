//
//  ScreenshotViewerController.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class ScreenshotViewerController: UIViewController {
    private let screenshots: [String]
    
    private var screenshotViewerView: ScreenshotViewerView {
        return self.view as! ScreenshotViewerView
    }
    
    init(screenshots: [String]) {
        self.screenshots = screenshots
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = ScreenshotViewerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.screenshotViewerView.collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseIdentifier)
        self.screenshotViewerView.collectionView.delegate = self
        self.screenshotViewerView.collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate
extension ScreenshotViewerController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

// MARK: - UICollectionViewDataSource
extension ScreenshotViewerController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.reuseIdentifier, for: indexPath) as! ScreenshotCell
        
        cell.configure(with: screenshots[indexPath.row])
        
        return cell
    }
}
