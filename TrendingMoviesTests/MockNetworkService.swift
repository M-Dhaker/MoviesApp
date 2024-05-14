//
//  MockNetworkService.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation
import Combine
@testable import TrendingMovies

class MockNetworkService: NetworkServiceProtocol {
    
    var shouldReturnError = false
    
    // Mock data for trending movies
    private let mockTrendingMovies: [TrendingMovie] = [
        TrendingMovie(id: 1, title: "Mock Movie 1", posterPath: "/mockPoster1.jpg"),
        TrendingMovie(id: 2, title: "Mock Movie 2", posterPath: "/mockPoster2.jpg")
    ]
    
    // Mock data for movie details
    private let mockMovieDetail = MovieDetail(id: 1, title: "Mock Movie 1", overview: "Mock overview", posterPath: "/mockPoster1.jpg")
    
    func fetchTrendingMovies() -> AnyPublisher<[TrendingMovie], Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            return Just(mockTrendingMovies)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchMovieDetails(movieId: Int) -> AnyPublisher<MovieDetail, Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            return Just(mockMovieDetail)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
