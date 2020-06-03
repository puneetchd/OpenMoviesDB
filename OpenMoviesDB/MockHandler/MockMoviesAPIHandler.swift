//
//  MockTrafficAPIHandler.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

class MockMoviesAPIHandler: MoviesAPIHandler {
    //Mock Movies API handler.
    
    override func searchMoviesWithName(forMovieName: String, forPageNumber: Int, completionHandler: @escaping MoviesSearchSuccessCompletionHandler, errorHandler: @escaping MoviesRequestErrorHandler) {
        if let path = Bundle.main.path(forResource: "MockMoviesListResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder: JSONDecoder = JSONDecoder()
                let models: DataMoviesModel = try decoder.decode(DataMoviesModel.self, from: data)
                completionHandler(models)
            } catch let parsingError {
                errorHandler(.genericError(code: 11, message: parsingError.localizedDescription))
            }
        }
    }
}
