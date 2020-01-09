//
//  LastfmService.swift
//  Lastfm
//
//  Created by Consultant on 1/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum LastfmError: Error { //associated value enum
    case badURL(String)
    case badDataTask(String)
    case badDecoder(String)
}

typealias AlbumHandler = ([Album]) -> Void
typealias ArtistHandler = ([Artist]) -> Void
typealias TrackHandler = ([Track]) -> Void

let lastfm = LastfmService.shared //property to easily access shared instance

final class LastfmService {
    
    
    static let shared = LastfmService()
    private init() {}
    
    
    func getAlbum(for albumName: String, completion: @escaping AlbumHandler) {
        
        guard let url = LastfmAPI(albumName).albumURL else {
            completion([])
            return //exit the scope
        }
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            if let error = err {
                print("Bad Data Task: \(error.localizedDescription)")
                completion([])
                return
            }
            
            if let data = dat {
                do {
                    let response = try JSONDecoder().decode(AlbumResponse.self, from: data)
                    let albums = response.results.albummatches.album
                    completion(albums)
                } catch {
                    print("Couldn't Serialize Object: \(error.localizedDescription)")
                    completion([])
                    return
                }
            }
        }.resume()
    }
    
    func getArtist(for artistName: String, completion: @escaping ArtistHandler) {
        
        guard let url = LastfmAPI(nil, artistName).artistURL else {
            completion([]) //return failure
            return //exit the scope
        }
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            if let error = err {
                print("Bad Data Task: \(error.localizedDescription)")
                completion([])
                return
            }
            
            if let data = dat {
                do {
                    let response = try JSONDecoder().decode(ArtistResponse.self, from: data)
                    let artists = response.results.artistmatches.artist
                    completion(artists)
                } catch {
                    print("Couldn't Serialize Object: \(error.localizedDescription)")
                    completion([])
                    return
                }
            }
        }.resume()
    }
    
    func getTrack(for trackName: String, completion: @escaping TrackHandler) {
        
        guard let url = LastfmAPI(nil, nil, trackName).trackURL else {
            completion([]) //return failure
            return //exit the scope
        }
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            if let error = err {
                print("Bad Data Task: \(error.localizedDescription)")
                completion([])
                return
            }
            
            if let data = dat {
                do {
                    let response = try JSONDecoder().decode(TrackResponse.self, from: data)
                    let tracks = response.results.trackmatches.track
                    completion(tracks)
                } catch {
                    print("Couldn't Serialize Object: \(error.localizedDescription)")
                    completion([])
                    return
                }
            }
        }.resume()
    }
 
    
}

