//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Evgenii Semenov on 11.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchViewInput: class {
    
    var searchResults: [ITunesApp] { get set }
    func showError(error: Error)
    func hideNoResults()
    func showNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput {
    
    func viewDidSearch(with query: String)
    func viewDidSelectApp(_ app: ITunesApp)
}

class SearchPresenter {
    
    private let searchService = ITunesSearchService()
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    private func requestApps(with query: String) {
        
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result
                .withValue { apps in
                    guard !apps.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = apps
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func openAppDetail(with app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        viewInput?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        requestApps(with: query)
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        openAppDetail(with: app)
    }
}
