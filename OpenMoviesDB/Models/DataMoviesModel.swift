//
//  DataMovies.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

struct DataMoviesModel: Codable {
    let moviesList: [Movie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case moviesList = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Movie: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}

// MARK: - Error
struct MovieResponseError: Codable {
    let response, errorMessage: String

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case errorMessage = "Error"
    }
}

