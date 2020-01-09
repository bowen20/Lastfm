//
//  ResultTableCell.swift
//  Lastfm
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ResultTableCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    static let identifier = "ResultTableCell"
    
    var artist: Artist! {
        didSet {
            mainLabel.text = artist.name
            if let imageLink = artist.image[1].link {
                guard let artworkUrl = URL(string: imageLink) else { return }
            artworkUrl.getImage { [weak self] img in
                if let image = img {
                    self?.mainImage.image = image
                }
            }
            }
        }
    }

    var album: Album! {
        didSet {
            mainLabel.text = album.name
            if let imageLink = album.image[1].link {
                guard let artworkUrl = URL(string: imageLink) else { return }
            artworkUrl.getImage { [weak self] img in
                if let image = img {
                    self?.mainImage.image = image
                }
            }
            }
        }
    }
    
    var track: Track! {
        didSet {
            mainLabel.text = track.name
            if let imageLink = track.image[1].link {
                guard let artworkUrl = URL(string: imageLink) else { return }
            artworkUrl.getImage { [weak self] img in
                if let image = img {
                    self?.mainImage.image = image
                }
            }
            }
        }
    }
    
}
