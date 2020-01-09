//
//  DetailViewController.swift
//  Lastfm
//
//  Created by Consultant on 1/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var linkButton: UIButton!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = viewModel.currentName
        guard let artworkUrl = URL(string: viewModel.currentImage) else { return }
        artworkUrl.getImage { [weak self] img in
            if let image = img {
                self?.mainImage.image = image
            }
        }
    }
    
    
    @IBAction func linkButton(_ sender: UIButton) {
        guard let url = URL(string: viewModel.currentSite) else { return }
         UIApplication.shared.open(url)
    }
}
