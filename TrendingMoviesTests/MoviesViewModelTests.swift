//
//  MoviesViewModelTests.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import XCTest
import Combine
@testable import TrendingMovies

class MoviesViewModelTests: XCTestCase {
    
    var viewModel: MoviesViewModel!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = MoviesViewModel(networkService: mockNetworkService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchTrendingMoviesSuccess() {
        // Given
        let movies = [TrendingMovie(id: 1, title: "Movie 1", posterPath: "/path1"),
                      TrendingMovie(id: 2, title: "Movie 2", posterPath: "/path2")]
        mockNetworkService.trendingMovies = movies
        
        // When
        let expectation = XCTestExpectation(description: "Fetch trending movies")
        viewModel.$trendingMovies
            .dropFirst()
            .sink { trendingMovies in
                // Then
                XCTAssertEqual(trendingMovies, movies)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchTrendingMovies()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchTrendingMoviesFailure() {
        // Given
        let error = URLError(.badServerResponse)
        mockNetworkService.error = error
        
        // When
        let expectation = XCTestExpectation(description: "Fetch trending movies failure")
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                // Then
                XCTAssertEqual(errorMessage, "fetch_trending_movies_error".localized + error.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchTrendingMovies()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchMovieDetailsSuccess() {
        // Given
        let movieDetail = MovieDetail(id: 1, title: "Movie 1", overview: "Overview 1", posterPath: "/path1")
        mockNetworkService.movieDetail = movieDetail
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movie details")
        viewModel.$movieDetails
            .dropFirst()
            .sink { movieDetails in
                // Then
                XCTAssertEqual(movieDetails, movieDetail)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchMovieDetails(movieId: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchMovieDetailsFailure() {
        // Given
        let error = URLError(.badServerResponse)
        mockNetworkService.error = error
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movie details failure")
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                // Then
                XCTAssertEqual(errorMessage, "fetch_movie_details_error".localized + error.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchMovieDetails(movieId: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
