//
//  SongDownloader.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 15.04.2023.
//  Copyright © 2023 ekireev. All rights reserved.
//

import Foundation

final class SongDownloader {
    public typealias CompletionSong = (URL) -> Void
    
    func downloadFromURL(_ url: URL, completion: @escaping CompletionSong) {
        var downloadTask: URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (localURL, response, error) in
            if let localURL = localURL {
                completion(localURL)
            }
        })
        
        downloadTask.resume()
    }
}
