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
    
    var trendingMovies: [TrendingMovie]?
    var movieDetail: MovieDetail?
    var error: Error?
    
    func fetchTrendingMovies() -> AnyPublisher<[TrendingMovie], Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(trendingMovies ?? [])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchMovieDetails(movieId: Int) -> AnyPublisher<MovieDetail, Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(movieDetail ?? MovieDetail(id: 0, title: "", overview: "", posterPath: nil))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

