//
//  MoviesAPIHandler.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

let kBaseUrl = "http://www.omdbapi.com/?apikey=b9bd48a6"

class MoviesAPIHandler: MovieAPIProtocol {

    private let networkHandler = BaseNetworkAPI.shared

    func searchMoviesWithName(forMovieName: String, completionHandler: @escaping MoviesSearchSuccessCompletionHandler, errorHandler: @escaping MoviesRequestErrorHandler) {
        let requestModel: NetworkRequestModel = NetworkRequestModel(requestType: NetworkRequestType.get, url: "\(kBaseUrl)&s=\(forMovieName)&type=movie", parameters: nil, headers: nil)

        networkHandler.createRequest(networkRequestModel: requestModel) { (data, networkError) in
            if let dataResponse: Data = data {
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let models: DataMoviesModel = try decoder.decode(DataMoviesModel.self, from: dataResponse)
                    completionHandler(models.moviesList)
                } catch let parsingError {
                    if let errorResponse = try? JSONDecoder().decode(MovieResponseError.self, from: dataResponse) {
                        errorHandler(.genericError(code: 400, message: errorResponse.errorMessage))
                    } else {
                        errorHandler(.genericError(code: 11, message: parsingError.localizedDescription))
                    }
                }
            } else {
                errorHandler(networkError)
            }
        }
    }

    func getMovieDetails(forMovieId: String, completionHandler: @escaping MoviesDetailsSuccessCompletionHandler , errorHandler: @escaping MoviesRequestErrorHandler) {
        let requestModel: NetworkRequestModel = NetworkRequestModel(requestType: NetworkRequestType.get, url: "\(kBaseUrl)&i=\(forMovieId)", parameters: nil, headers: nil)

        networkHandler.createRequest(networkRequestModel: requestModel) { (data, networkError) in
            if let dataResponse: Data = data {
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let models: DataMovieDetailsModel = try decoder.decode(DataMovieDetailsModel.self, from: dataResponse)
                    completionHandler(models)
                } catch let parsingError {
                    if let errorResponse = try? JSONDecoder().decode(MovieResponseError.self, from: dataResponse) {
                        errorHandler(.genericError(code: 400, message: errorResponse.errorMessage))
                    } else {
                        errorHandler(.genericError(code: 11, message: parsingError.localizedDescription))
                    }
                }
            } else {
                errorHandler(networkError)
            }
        }
    }

}
