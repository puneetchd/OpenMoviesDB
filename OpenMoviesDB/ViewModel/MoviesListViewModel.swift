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
    var hasMore = true
    var movies: [Movie] = []
    private var currentPage = 1

    //MARK:- Init Methods
    init(apiHandler: MovieAPIProtocol) {
        networkHandler = apiHandler
    }

    func startFreshMoviesSearch(titleName: String) {
        movies.removeAll()
        currentPage = 1
        fetchMoviesForSearchTerm(movieName: titleName)
    }

    func fetchMoviesForSearchTerm(movieName: String) {
        self.isFetchingResults = true
        if movieName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 { return }
        networkHandler.searchMoviesWithName(
            forMovieName: movieName, forPageNumber: currentPage,
            completionHandler: { [weak self] (moviesModel) in
                self?.movies.append(contentsOf: moviesModel?.moviesList ?? [])
                if (self?.getNoOfMovies())! < Int(moviesModel?.totalResults ?? "") ?? 0 {
                    self?.hasMore = true
                    self?.currentPage += 1
                } else {
                    self?.hasMore = false
                }
                self?.isFetchingResults = false
                self?.callbackHandler?(Callback.reloadContent)
            }
        ) { (networkError) in
            self.isFetchingResults = false
            self.callbackHandler?(Callback.hideLoader)
            self.callbackHandler?(Callback.showError(error: networkError!))
        }
    }

    func movieObjectAt(at index: Int) -> Movie {
        return movies[index]
    }

    func getNoOfMovies() -> Int {
        return movies.count
    }
}
