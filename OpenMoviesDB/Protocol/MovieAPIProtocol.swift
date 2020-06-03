//
//  MovieAPIProtocol.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

protocol MovieAPIProtocol {
    func searchMoviesWithName(forMovieName: String, completionHandler: @escaping MoviesSearchSuccessCompletionHandler, errorHandler: @escaping MoviesRequestErrorHandler)
    func getMovieDetails(forMovieId: String, completionHandler: @escaping MoviesDetailsSuccessCompletionHandler, errorHandler: @escaping MoviesRequestErrorHandler)
}
