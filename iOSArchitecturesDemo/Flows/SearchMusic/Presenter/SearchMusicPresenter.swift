//
//  SearchMusicPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 14.04.2023.
//

import UIKit
import Alamofire

protocol SearchMusicViewInput {
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func hideNoResults()
    func showNoResults()
    func throbber(show: Bool)
}

protocol SearchMusicViewOutput {
    func viewDidSearch(with query: String)
    func viewDidSelectSong(_ song: ITunesSong)
}

class SearchMusicPresenter {
    private let searchService = ITunesSearchService()
    
    weak var viewInput: (UIViewController & SearchMusicViewInput)?
    
    private func requestMusic(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result
                .withValue { songs in
                    guard !songs.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = songs
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func openSongDetail(with song: ITunesSong) {
        if let url = URL(string: song.trackUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
}

extension SearchMusicPresenter: SearchMusicViewOutput {
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        requestMusic(with: query)
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
        openSongDetail(with: song)
    }
}
