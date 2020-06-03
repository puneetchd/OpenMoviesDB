//
//  MovieDetailsViewModel.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    private let networkHandler: MovieAPIProtocol
    var callbackHandler: CallbackHandler?
    var isFetchingResults = false
    var movieDetails: DataMovieDetailsModel?

    //MARK:- Init Methods
    init(apiHandler: MovieAPIProtocol) {
        networkHandler = apiHandler
    }

    func fetchMovieDetailForId(movieId: String) {
        networkHandler.getMovieDetails(
            forMovieId: movieId,
            completionHandler: { [weak self] (dataMovieDetails) in
                self?.movieDetails = dataMovieDetails
                self?.callbackHandler?(Callback.reloadContent)
            }
        ) { (networkError) in
            self.callbackHandler?(Callback.hideLoader)
            self.callbackHandler?(Callback.showError(error: networkError!))
        }
    }
    
    func getImageURL() -> String {
        return movieDetails?.poster ?? ""
    }
    
    func getMovieTitle() -> String {
        return movieDetails?.title ?? ""
    }
    
    func getMovieYear() -> String {
        return "Year: " + (movieDetails?.year ?? "N/A")
    }
    
    func getMovieRating() -> String {
        return "Rating: " + (movieDetails?.imdbRating ?? "0.0")
    }
    
    func getMovieLength() -> String {
        return "Length: " + (movieDetails?.runtime ?? "0hr")
    }
    
    func getMoviePlot() -> String {
        return "Plot: " + (movieDetails?.plot ?? "")
    }
    
    func getMovieScore() -> String {
        return movieDetails?.metascore ?? ""
    }
    
    func getMovieVotes() -> String {
        return "Votes: " + (movieDetails?.imdbVotes ?? "0")
    }
    
    func getMovieType() -> String {
        return (movieDetails?.type ?? "").uppercased()
    }
    
    func getMovieLanguage() -> String {
        return "Language : " + (movieDetails?.language ?? "English")
    }
    
    func getMovieCountry() -> String {
        return "Country : " + (movieDetails?.country ?? "US")
    }
    
    func getMovieAwards() -> String {
        return "Awards: " + (movieDetails?.awards ?? "N/A")
    }
}
