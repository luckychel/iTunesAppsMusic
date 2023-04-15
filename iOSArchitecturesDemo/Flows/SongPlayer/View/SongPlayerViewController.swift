//
//  SongPlayerViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SongPlayerViewController: UIViewController {
    private let songViewModel: SongPlayerViewModelInput
    let disposeBag = DisposeBag()
    
    private var songPlayerView: SongPlayerView {
        return self.view as! SongPlayerView
    }
    
    init(song: ITunesSong) {
        self.songViewModel = SongPlayerViewModel(song: song)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SongPlayerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songPlayerView.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        songPlayerView.stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        
        // Observers
        setupSongImageViewObserver()
        setupSongNameObserver()
        setupSingerNameObserver()
        setupPlayerStateObserver()
    }
    
    @objc private func playButtonTapped(sender: UIButton) {
        songPlayerView.animateButton(button: sender)
        songPlayerView.disableControls()
        songViewModel.playSong()
    }
    
    @objc private func stopButtonTapped(sender: UIButton) {
        songPlayerView.animateButton(button: sender)
        songViewModel.stopSong()
    }
}

// MARK: - Rx Setup
extension SongPlayerViewController {
    func setupSongImageViewObserver() {
        songViewModel.artwork.asObservable()
            .subscribe(onNext: { [unowned self] urlString in
                let url = URL(string: urlString ?? "")
                self.songPlayerView.songImageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
    }
    
    func setupSongNameObserver() {
        songViewModel.songName.asObservable()
            .subscribe(onNext: { [unowned self] songName in
                self.songPlayerView.songNameLabel.text = songName
            })
            .disposed(by: disposeBag)
    }
    
    func setupSingerNameObserver() {
        songViewModel.singerName.asObservable()
            .subscribe(onNext: { [unowned self] singerName in
                self.songPlayerView.singerLabel.text = singerName
            })
            .disposed(by: disposeBag)
    }
    
    func setupPlayerStateObserver() {
        songViewModel.playerState
            .subscribe(onNext: { [weak self] state in
                self?.songPlayerView.changePlayButton(to: state)
                self?.songPlayerView.enableContols()
            })
            .disposed(by: disposeBag)
    }
}
