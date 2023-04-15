//
//  SearchMusicInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import Alamofire

protocol SearchMusicInteractorInput {
    func requestSongs(with querry: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}

class SearchMusicInteractor: SearchMusicInteractorInput {
    private let searchService = ITunesSearchService()
    
    func requestSongs(with querry: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        searchService.getSongs(forQuery: querry, completion: completion)
    }
}
