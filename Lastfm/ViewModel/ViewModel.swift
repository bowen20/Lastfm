//
//  ViewModel.swift
//  Lastfm
//
//  Created by Consultant on 1/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func update()
}

class ViewModel {
    
    weak var delegate: ViewModelDelegate?
    
    var albums = [Album]() {
        didSet {
            delegate?.update()
        }
    }
    
    var artists = [Artist]() {
        didSet {
            delegate?.update()

        }
    }
    
    var tracks = [Track]() {
        didSet {
            delegate?.update()

        }
    }
    
    var currentName: String!
    
    var currentImage: String!
    
    var currentSite: String!
        
}

extension ViewModel {
    
    func getAlbum(_ albumName: String) {
        lastfm.getAlbum(for: albumName) { [weak self] albumsResult in
                self?.albums = albumsResult
        }
        
    }
    
    func getArtist(_ artistName: String) {
        lastfm.getArtist(for: artistName) { [weak self] artistsResult in
                self?.artists = artistsResult
        }
    }
    
    func getTrack(_ trackName: String) {
        lastfm.getTrack(for: trackName) { [weak self] tracksResult in
                self?.tracks = tracksResult
        }
    }
}
