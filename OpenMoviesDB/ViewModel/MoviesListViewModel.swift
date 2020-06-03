//
//  MoviesListViewModel.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

class MoviesListViewModel {
    private let networkHandler: MovieAPIProtocol
    var callbackHandler: CallbackHandler?
    var isFetchingResults = false
    var movies: [Movie]?

    //MARK:- Init Methods
    init(apiHandler: MovieAPIProtocol) {
        networkHandler = apiHandler
    }

    func fetchMoviesForSearchTerm(titleName: String) {
        self.isFetchingResults = false
        if titleName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 { return }
        networkHandler.searchMoviesWithName(
            forMovieName: titleName,
            completionHandler: { [weak self] (moviesList) in
                self?.movies = moviesList
                self?.callbackHandler?(Callback.reloadContent)
            }
        ) { (networkError) in
            self.isFetchingResults = false
            self.callbackHandler?(Callback.hideLoader)
            self.callbackHandler?(Callback.showError(error: networkError!))
        }
    }

    func movieObjectAt(at index: Int) -> Movie {
        return movies![index]
    }

    func getNoOfMovies() -> Int {
        return movies?.count ?? 0
    }
}
