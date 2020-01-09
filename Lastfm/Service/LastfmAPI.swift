//
//  LastfmAPI.swift
//  Lastfm
//
//  Created by Consultant on 1/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct LastfmAPI {

//https://ws.audioscrobbler.com/2.0/?method=album.search&album=chvrches&api_key=4ff37e253103ea6b93bcda50d12ed292&format=json

//https://ws.audioscrobbler.com/2.0/?method=artist.search&artist=chvrches&api_key=4ff37e253103ea6b93bcda50d12ed292&format=json
    
//https://ws.audioscrobbler.com/2.0/?method=track.search&track=chvrches&api_key=4ff37e253103ea6b93bcda50d12ed292&format=json
    
    var albumName: String!
    var artistName: String!
    var trackName: String!
    
    let albumSearch = "https://ws.audioscrobbler.com/2.0/?method=album.search&album="
    let artistSearch = "https://ws.audioscrobbler.com/2.0/?method=artist.search&artist="
    let trackSearch = "https://ws.audioscrobbler.com/2.0/?method=track.search&track="
    let end = "&api_key=4ff37e253103ea6b93bcda50d12ed292&format=json"
    
    init(_ album: String? = nil, _ artist: String? = nil, _ track: String? = nil) {
        self.albumName = album
        self.artistName = artist
        self.trackName = track
    }
    
    var albumURL: URL? {
        guard let name = albumName else { return nil }
        return URL(string: albumSearch + "\(name)" + end)
    }
    
    var artistURL: URL? {
        guard let name = artistName else { return nil }
        return URL(string: artistSearch + "\(name)" + end)
    }
    
    var trackURL: URL? {
        guard let name = trackName else { return nil }
        return URL(string: trackSearch + "\(name)" + end)
    }
    
}
