//
//  AppDetailScreenshotsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 14.04.2023.
//

import UIKit

class AppDetailScreenshotsViewController: UIViewController {
    private let app: ITunesApp
    
    enum ConstantSizes: Int {
        case cellWidth = 250
        case cellHeight = 445
    }
    
    private var appDetailScreenshotsView: AppDetailScreenshotsView {
        return self.view as! AppDetailScreenshotsView
    }
    
    init(app: ITunesApp) {
        self.app = app

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailScreenshotsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDetailScreenshotsView.collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseIdentifier)
        self.appDetailScreenshotsView.collectionView.delegate = self
        self.appDetailScreenshotsView.collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AppDetailScreenshotsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: ConstantSizes.cellWidth.rawValue,
            height: ConstantSizes.cellHeight.rawValue
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
}

// MARK: - UICollectionViewDelegate
extension AppDetailScreenshotsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screenshotViewerController = ScreenshotViewerController(screenshots: app.screenshotUrls)
        navigationController?.pushViewController(screenshotViewerController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension AppDetailScreenshotsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.reuseIdentifier, for: indexPath) as! ScreenshotCell
        
        cell.configure(with: app.screenshotUrls[indexPath.row])
        
        return cell
    }
}
