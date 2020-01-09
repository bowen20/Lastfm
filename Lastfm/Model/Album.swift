//
//  Album.swift
//  Lastfm
//
//  Created by Consultant on 1/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct AlbumResponse: Decodable {
    let results: AlbumResults
}

struct AlbumResults: Decodable {
    let albummatches: AlbumMatches
}

struct AlbumMatches: Decodable {
    let album: [Album]
}

class Album: Decodable {
    let name: String
    let image: [Image]
    let url: String
}

struct Image: Decodable {
    let link: String?
    let size: String?
    
    private enum CodingKeys: String, CodingKey {
         case link = "#text"
         case size
     }
}

