//
//  Track.swift
//  Lastfm
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct TrackResponse: Decodable {
    let results: TrackResults
}

struct TrackResults: Decodable {
    let trackmatches: TrackMatches
}

struct TrackMatches: Decodable {
    let track: [Track]
}

class Track: Decodable {
    let name: String
    let image: [Image]
    let url: String
}
