//
//  NetworkService.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation
import Combine

/// Protocol defining the methods for fetching movies
protocol NetworkServiceProtocol {
    func fetchTrendingMovies() -> AnyPublisher<[TrendingMovie], Error>
    func fetchMovieDetails(movieId: Int) -> AnyPublisher<MovieDetail, Error>
}

/// Singleton class to manage network requests
class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    
    static let shared = NetworkService() // Singleton instance
    private let baseURL = "https://api.themoviedb.org/3" // Base URL for the API
    private let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3" // API key for authentication
    
    private init() {} // Private initializer to ensure singleton usage
    
    // MARK: - Network Methods
    
    /// Fetches trending movies from the API
    /// - Returns: A publisher that outputs an array of TrendingMovie or an error
    func fetchTrendingMovies() -> AnyPublisher<[TrendingMovie], Error> {
        // Construct the URL for the trending movies endpoint
        guard let url = URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)") else {
            fatalError("Invalid URL")
        }
        
        // Create and return a publisher that fetches data, decodes it, and handles errors
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .eraseToAnyPublisher()
    }
    
    /// Fetches details for a specific movie from the API
    /// - Parameter movieId: The ID of the movie to fetch details for
    /// - Returns: A publisher that outputs a MovieDetail or an error
    func fetchMovieDetails(movieId: Int) -> AnyPublisher<MovieDetail, Error> {
        // Construct the URL for the movie details endpoint
        guard let url = URL(string: "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)") else {
            fatalError("Invalid URL")
        }
        
        // Create and return a publisher that fetches data, decodes it, and handles errors
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MovieDetail.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
