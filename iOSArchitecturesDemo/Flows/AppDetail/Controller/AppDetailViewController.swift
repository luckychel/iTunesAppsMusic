//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)

        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    public var app: ITunesApp
    
    lazy var headerDetailViewController = AppDetailHeaderViewController(app: app)
    lazy var descriptionViewController = AppDetailDescriptionViewController(app: app)
    lazy var screenshotsViewController = AppDetailScreenshotsViewController(app: app)
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureUI()
        self.configureNavigationController()
        
        addChildViewController()
        addDescriptionViewController()
        addScreenshotsViewController()
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureUI() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func addChildViewController() {
        contentView.addSubview(headerDetailViewController.view)
        addChild(headerDetailViewController)
        headerDetailViewController.didMove(toParent: self)
        
        headerDetailViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerDetailViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerDetailViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            headerDetailViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    private func addDescriptionViewController() {
        contentView.addSubview(descriptionViewController.view)
        addChild(descriptionViewController)
        descriptionViewController.didMove(toParent: self)
        
        descriptionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionViewController.view.topAnchor.constraint(equalTo: headerDetailViewController.view.bottomAnchor),
            descriptionViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptionViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    private func addScreenshotsViewController() {
        contentView.addSubview(screenshotsViewController.view)
        addChild(screenshotsViewController)
        screenshotsViewController.didMove(toParent: self)
        
        screenshotsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            screenshotsViewController.view.topAnchor.constraint(equalTo: descriptionViewController.view.bottomAnchor),
            screenshotsViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            screenshotsViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            screenshotsViewController.view.heightAnchor.constraint(equalToConstant: 500),
            screenshotsViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
