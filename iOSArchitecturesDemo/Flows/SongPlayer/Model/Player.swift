//
//  Player.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import Foundation
import AVFoundation
import RxCocoa

enum PlayerState {
    case playing
    case paused
    case stopped
}

final class Player: NSObject {
    private var player: AVAudioPlayer? = nil
    
    public lazy var state: BehaviorRelay<PlayerState> = BehaviorRelay(value: currentState)
    
    private var currentState: PlayerState = .stopped {
        didSet {
            state.accept(currentState)
        }
    }
    
    func play(with url: URL) -> Bool {
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
            currentState = .playing
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func pause() {
        player?.pause()
        currentState = .paused
    }
    
    func resume() {
        player?.play()
        currentState = .playing
    }
    
    func stop() {
        player?.stop()
        currentState = .stopped
        player = nil
    }
}

extension Player: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        currentState = .stopped
    }
}
