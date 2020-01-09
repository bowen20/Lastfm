//
//  HomeViewController.swift
//  Lastfm
//
//  Created by Consultant on 1/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    let viewModel = ViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupHome()
            searchSetup()
        }
        
        private func setupHome() {
            homeTableView.register(UINib(nibName: ResultTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ResultTableCell.identifier)
            homeTableView.tableFooterView = UIView(frame: .zero)
            homeTableView.separatorStyle = .none
            viewModel.delegate = self
        }
        
        private func searchSetup() {
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        }
        
    }

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 3
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = [viewModel.artists.count, viewModel.albums.count, viewModel.tracks.count]
        return rows[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableCell.identifier, for: indexPath) as! ResultTableCell
        switch indexPath.section {
        case 0:
            if viewModel.artists.count > 0 {
            let artist = viewModel.artists[indexPath.row]
            cell.artist = artist
            }
        case 1:
            if viewModel.albums.count > 0 {
            let album = viewModel.albums[indexPath.row]
            cell.album = album
            }
        default:
            if viewModel.tracks.count > 0 {
            let track = viewModel.tracks[indexPath.row]
            cell.track = track
            }
        }
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headers = ["Artist", "Album", "Track"]
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            viewModel.currentName = viewModel.artists[indexPath.row].name
            viewModel.currentImage = viewModel.artists[indexPath.row].image[2].link
            viewModel.currentSite = viewModel.artists[indexPath.row].url
        case 1:
            viewModel.currentName = viewModel.albums[indexPath.row].name
            viewModel.currentImage = viewModel.albums[indexPath.row].image[2].link
            viewModel.currentSite = viewModel.albums[indexPath.row].url
        default:
            viewModel.currentName = viewModel.tracks[indexPath.row].name
            viewModel.currentImage = viewModel.tracks[indexPath.row].image[2].link
            viewModel.currentSite = viewModel.tracks[indexPath.row].url
        }
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.viewModel = viewModel
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

    extension HomeViewController: ViewModelDelegate {
        
        func update() {
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        }
    }

    extension HomeViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let search = searchBar.text,
                let sanitized = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        }
    }
    
extension HomeViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let search = searchController.searchBar.text, let sanitized = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        viewModel.getArtist(sanitized)
        viewModel.getAlbum(sanitized)
        viewModel.getTrack(sanitized)

    }

}



