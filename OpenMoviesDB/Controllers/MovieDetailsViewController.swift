//
//  MovieDetailsViewController.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    private let viewModel: MovieDetailsViewModel = MovieDetailsViewModel(apiHandler: MoviesAPIHandler())
    var movieId:String!
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblMovieLength: UILabel!
    @IBOutlet weak var lblMoviePlot: UILabel!
    @IBOutlet weak var lblVOtes: UILabel!
    @IBOutlet weak var lblMetaScore: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lbllanguage: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblAwards: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHandlers()
        viewModel.fetchMovieDetailForId(movieId: movieId)
    }
    
    private func addHandlers() {
        viewModel.callbackHandler = { [weak self] (callbackType: Callback) in
            if let weakSelf: MovieDetailsViewController = self {
                DispatchQueue.main.async {
                    switch callbackType {
                    case .showLoader:
                        weakSelf.activityView.startAnimating()
                    case .hideLoader:
                        weakSelf.activityView.stopAnimating()
                    case .reloadContent:
                        weakSelf.setMovieDetailsToView()
                        UIView.animate(withDuration: 0.25) {
                            weakSelf.containerScrollView.alpha = 1
                        }
                    case .showError(let error):
                        weakSelf.activityView.stopAnimating()
                        showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: weakSelf)
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func setMovieDetailsToView() {
        movieImgView.loadImageUsingCache(withUrl: viewModel.getImageURL())
        lblMovieTitle.text = viewModel.getMovieTitle()
        lblYear.text = viewModel.getMovieYear()
        lblRating.text = viewModel.getMovieRating()
        lblMovieLength.text = viewModel.getMovieLength()
        lblMoviePlot.text = viewModel.getMoviePlot()
        lblVOtes.text = viewModel.getMovieVotes()
        lblMetaScore.text = viewModel.getMovieScore()
        lblType.text = viewModel.getMovieType()
        lbllanguage.text = viewModel.getMovieLanguage()
        lblCountry.text = viewModel.getMovieCountry()
        lblAwards.text = viewModel.getMovieAwards()
        containerScrollView.contentSize = CGSize(width: view.frame.size.width, height: lblAwards.frame.maxY + 20)
    }
}
