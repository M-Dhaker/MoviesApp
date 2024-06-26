//
//  NetworkServiceTests.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import XCTest
import Combine
@testable import TrendingMovies

class NetworkServiceTests: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        cancellables = []
    }
    
    override func tearDown() {
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchTrendingMoviesSuccess() {
        // Given
        let movies = [TrendingMovie(id: 1, title: "Mock Movie 1", posterPath: "/mockPoster1.jpg"),
                      TrendingMovie(id: 2, title: "Mock Movie 2", posterPath: "/mockPoster2.jpg")]
        mockNetworkService.trendingMovies = movies
        
        // When
        let expectation = XCTestExpectation(description: "Fetch trending movies")
        mockNetworkService.fetchTrendingMovies()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { receivedMovies in
                // Then
                XCTAssertEqual(receivedMovies, movies)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchTrendingMoviesFailure() {
        // Given
        let error = URLError(.badServerResponse)
        mockNetworkService.error = error
        
        // When
        let expectation = XCTestExpectation(description: "Fetch trending movies failure")
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
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchMovieDetailsSuccess() {
        // Given
        let movieDetail = MovieDetail(id: 1, title: "Mock Movie 1", overview: "Mock overview", posterPath: "/mockPoster1.jpg")
        mockNetworkService.movieDetail = movieDetail
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movie details")
        mockNetworkService.fetchMovieDetails(movieId: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { receivedMovieDetail in
                // Then
                XCTAssertEqual(receivedMovieDetail, movieDetail)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchMovieDetailsFailure() {
        // Given
        let error = URLError(.badServerResponse)
        mockNetworkService.error = error
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movie details failure")
        mockNetworkService.fetchMovieDetails(movieId: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

