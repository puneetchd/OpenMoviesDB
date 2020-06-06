//
//  MoviesServiceTests.swift
//  OpenMoviesDBTests
//
//  Created by Puneet Sharma on 6/6/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import XCTest

class MoviesServiceTests: XCTestCase {
    
    var moviesServiceHandler = MoviesAPIHandler()
    let timeOutDuration = 4.0

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMoviesSearchService() {
        let promise: XCTestExpectation = expectation(description: "Movies Search Results.")
        moviesServiceHandler.searchMoviesWithName(forMovieName: "Lego", forPageNumber: 1, completionHandler: { (moviesResultModel) in
            if (moviesResultModel?.moviesList.count)! > 0 {
                promise.fulfill()
            } else {
                XCTFail("Failed to fetch results or parsing issue")
            }
        }) { (networkError) in
            XCTFail("searchMoviesWithName() : Network exception occured " + (networkError?.localizedDescription ?? ""))
        }
        wait(for: [promise], timeout: timeOutDuration)
    }
    
    func testMoviesDetailsService() {
        let promise: XCTestExpectation = expectation(description: "Movie Details Results.")
        moviesServiceHandler.getMovieDetails(forMovieId: "tt4154664", completionHandler: { (movieDetailsModel) in
            if let detailsObj = movieDetailsModel {
                XCTAssertEqual(detailsObj.title, "Captain Marvel", "Movie Title not as expected")
                XCTAssertEqual("tt4154664", detailsObj.imdbID)
                promise.fulfill()
            } else {
                XCTFail("Failed to fetch Details or model parsing issue")
            }
        }) { (networkError) in
            XCTFail("getMovieDetails() : Network exception occured " + (networkError?.localizedDescription ?? ""))
        }
        wait(for: [promise], timeout: timeOutDuration)
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
