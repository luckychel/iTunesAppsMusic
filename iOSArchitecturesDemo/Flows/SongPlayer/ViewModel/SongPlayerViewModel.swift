//
//  SongPlayerViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SongPlayerViewModelInput {
    var songName: BehaviorRelay<String> { get }
    var singerName: BehaviorRelay<String?> { get }
    var artwork: BehaviorRelay<String?> { get }
    var playerState: BehaviorRelay<PlayerState> { get }
    
    var song: ITunesSong { get }
    var player: Player { get }
    
    func playSong()
    func stopSong()
}

class SongPlayerViewModel: SongPlayerViewModelInput {
    lazy var songName: BehaviorRelay<String> = BehaviorRelay(value: song.trackName)
    lazy var singerName: BehaviorRelay<String?> = BehaviorRelay(value: song.artistName)
    lazy var artwork: BehaviorRelay<String?> = BehaviorRelay(value: song.artwork)
    lazy var playerState: BehaviorRelay<PlayerState> = player.state
    
    internal let song: ITunesSong
    internal let player: Player
    private let songDownloader: SongDownloader
    private var shouldTryAgain: Bool = true
    
    init(song: ITunesSong) {
        self.song = song
        self.player = Player()
        self.songDownloader = SongDownloader()
    }
    
    func playSong() {
        switch player.state.value {
        case .playing:
            player.pause()
        case .paused:
            player.resume()
        case .stopped:
            play()
        }
    }
    
    func stopSong() {
        player.stop()
    }
    
    func play() {
        guard let url = URL(string: song.previewUrl ?? "") else { return }
        songDownloader.downloadFromURL(url) { localURL in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if !self.player.play(with: localURL) &&
                    self.shouldTryAgain {
                    self.shouldTryAgain = false
                    self.play()
                }
            }
        }
    }
}
