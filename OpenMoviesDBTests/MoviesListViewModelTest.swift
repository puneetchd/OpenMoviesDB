//
//  MoviesListViewModelTest.swift
//  OpenMoviesDBTests
//
//  Created by Puneet Sharma on 6/4/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import XCTest

class MoviesListViewModelTest: XCTestCase {
    
    //MARK:- Variables
    var moviesListViewModel: MoviesListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moviesListViewModel = MoviesListViewModel(apiHandler: MockMoviesAPIHandler())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        moviesListViewModel = nil
    }
    
    func testMoviesListFetch() {
        let promise: XCTestExpectation = expectation(description: "fetched Objects count > 0")
        moviesListViewModel.callbackHandler = { (callbackType: Callback) in
            switch callbackType {
            case .showError(let error):
                XCTFail(error.localizedDescription)
            case .reloadContent:
                promise.fulfill()
            default:
                break
            }
        }
        
        moviesListViewModel.startFreshMoviesSearch(titleName: "Lego")
        wait(for: [promise], timeout: 4)
        XCTAssertEqual(self.moviesListViewModel.getNoOfMovies(), 10, "Unable to parse all objects")
    }
    
    func testMovieObjectAtRow() {
        let promise: XCTestExpectation = expectation(description: "fetched Objects count > 0")
        moviesListViewModel.callbackHandler = { (callbackType: Callback) in
            switch callbackType {
            case .showError(let error):
                XCTFail(error.localizedDescription)
            case .reloadContent:
                promise.fulfill()
            default:
                break
            }
        }
        
        moviesListViewModel.startFreshMoviesSearch(titleName: "Lego")
        wait(for: [promise], timeout: 4)
        XCTAssertTrue(moviesListViewModel.movieObjectAt(at: 0).title == "Captain Marvel", "Title not parsed correctly")
        XCTAssertTrue(moviesListViewModel.movieObjectAt(at: 0).poster == "https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg", "Image URL not parsed correctly")
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
