//
//  ViewController.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    private let viewModel: MoviesListViewModel = MoviesListViewModel(apiHandler: MoviesAPIHandler())
    @IBOutlet weak var topSearchBar: UISearchBar!
    @IBOutlet weak var moviesListCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        moviesListCollectionView.collectionViewLayout.invalidateLayout()
        // Do any additional setup after loading the view.
    }

    func setUpUI() {
        self.title = "OMDB Movies"
        addHandlers()
    }

    private func addHandlers() {
        viewModel.callbackHandler = { [weak self] (callbackType: Callback) in
            if let weakSelf: MoviesListViewController = self {
                DispatchQueue.main.async {
                    switch callbackType {
                    case .showLoader:
                        weakSelf.title = "Searching..."
                    case .hideLoader:
                        weakSelf.title = "OMDB Movies"
                    case .reloadContent:
                        weakSelf.moviesListCollectionView.reloadData()
                    case .showError(let error):
                        showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: weakSelf)
                    }
                }
            }
        }
    }
}

extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNoOfMovies()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell: MovieListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCellIdentifier", for: indexPath) as! MovieListCell
        collectionViewCell.setMovieCellData(movieObj: viewModel.movieObjectAt(at: indexPath.row))
        return collectionViewCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 2) - 20, height: 249)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieDetailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVCIdentifier") as? MovieDetailsViewController else { return }
        movieDetailsVC.movieId = viewModel.movieObjectAt(at: indexPath.row).imdbID
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

extension MoviesListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchMoviesForSearchTerm(titleName: searchBar.text ?? "")
        view.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }
}
