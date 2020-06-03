//
//  MoviesDataModelTest.swift
//  OpenMoviesDBTests
//
//  Created by Puneet Sharma on 6/4/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import XCTest

class MoviesDataModelTest: XCTestCase {
    
    //MARK:- Variables
    var dataMoviesModel: DataMoviesModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataMoviesModel = DataMoviesModel(moviesList: [Movie(title: "lego", year: "2017", imdbID: "34343543", type: TypeEnum.movie, poster: "https://m.media-amazon.com/images/M/MV5BMTg4MDk1ODExN15BMl5BanBnXkFtZTgwNzIyNjg3MDE@._V1_SX300.jpg")], totalResults: "1", response: "True")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataMoviesModel = nil
    }
    
    func testImageURL() {
        let imageURL: String? = dataMoviesModel.moviesList.first?.poster
        if let imageURL: String = imageURL {
            XCTAssertEqual(imageURL, "https://m.media-amazon.com/images/M/MV5BMTg4MDk1ODExN15BMl5BanBnXkFtZTgwNzIyNjg3MDE@._V1_SX300.jpg", "Invalid image url")
        } else {
            XCTAssertNotNil(imageURL, "Invalid image url")
        }
    }
    
    func testNumberOfResponseItems() {
        XCTAssertEqual(dataMoviesModel.moviesList.count, Int(dataMoviesModel.totalResults), "Pagination Error causing incorrect reponse count")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
