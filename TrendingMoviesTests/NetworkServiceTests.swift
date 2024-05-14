//
//  NetworkServiceTests.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation
import XCTest
import Combine
@testable import TrendingMovies

class NetworkServiceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockNetworkService = MockNetworkService()
    }
    
    override func tearDown() {
        cancellables = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchTrendingMoviesSuccess() {
        let expectation = XCTestExpectation(description: "Fetch trending movies")
        
        mockNetworkService.shouldReturnError = false
        
        mockNetworkService.fetchTrendingMovies()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { movies in
                XCTAssertNotNil(movies)
                XCTAssertEqual(movies.count, 2)
                XCTAssertEqual(movies.first?.title, "Mock Movie 1")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchMovieDetailsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch movie details")
        
        mockNetworkService.shouldReturnError = false
        let testMovieId = 1 // Example movie ID
        
        mockNetworkService.fetchMovieDetails(movieId: testMovieId)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { movieDetail in
                XCTAssertNotNil(movieDetail)
                XCTAssertEqual(movieDetail.id, testMovieId)
                XCTAssertEqual(movieDetail.title, "Mock Movie 1")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchTrendingMoviesFailure() {
        let expectation = XCTestExpectation(description: "Fetch trending movies failure")
        
        mockNetworkService.shouldReturnError = true
        
        mockNetworkService.fetchTrendingMovies()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchMovieDetailsFailure() {
        let expectation = XCTestExpectation(description: "Fetch movie details failure")
        
        mockNetworkService.shouldReturnError = true
        let testMovieId = 1 // Example movie ID
        
        mockNetworkService.fetchMovieDetails(movieId: testMovieId)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
