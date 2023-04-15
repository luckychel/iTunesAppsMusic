//
//  SearchMusicBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import UIKit

class SearchMusicBuilder {
    static func build() -> (UIViewController & SearchMusicViewInput) {
        let interactor = SearchMusicInteractor()
        let router = SearchMusicRouter()
        
        let presenter = SearchMusicPresenter(interactor: interactor, router: router)
        
        let viewController = SearchMusicViewController(presenter: presenter)
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
}
