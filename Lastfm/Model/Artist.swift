//
//  Artist.swift
//  Lastfm
//
//  Created by Consultant on 1/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct ArtistResponse: Decodable {
    let results: ArtistResults
}

struct ArtistResults: Decodable {
    let artistmatches: ArtistMatches
}

struct ArtistMatches: Decodable {
    let artist: [Artist]
}

class Artist: Decodable {
    let name: String
    let image: [Image]
    let url: String
}
