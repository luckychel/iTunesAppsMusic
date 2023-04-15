//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let trackName: String?
    let artistName: String?
    let artworkURL: String?
}

final class SongCellModelFactory {
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(
            trackName: model.trackName,
            artistName: model.artistName,
            artworkURL: model.artwork
        )
    }
}
