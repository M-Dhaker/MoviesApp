//
//  MoviesViewModel.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation
import Combine

/// ViewModel to manage fetching and storing movie data
class MoviesViewModel: ObservableObject {
    @Published var trendingMovies: [TrendingMovie] = []    // Published property for trending movies
    @Published var movieDetails: MovieDetail?              // Published property for movie details
    @Published var errorMessage: String?                   // Published property for error messages

    private var cancellables = Set<AnyCancellable>()       // Set to store Combine subscriptions
    private let networkService: NetworkServiceProtocol     // Network service to fetch data

    /// Initializer with dependency injection for network service
    /// - Parameter networkService: Protocol for network service, default is NetworkService.shared
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }

    /// Fetches trending movies and updates `trendingMovies` property
    func fetchTrendingMovies() {
        networkService.fetchTrendingMovies()
            .receive(on: DispatchQueue.main)               // Ensure updates happen on main thread
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "fetch_trending_movies_error".localized + error.localizedDescription  // Handle error by updating errorMessage
                }
            }, receiveValue: { [weak self] movies in
                self?.trendingMovies = movies               // Update trendingMovies with fetched data
            })
            .store(in: &cancellables)                       // Store subscription in cancellables
    }

    /// Fetches details of a specific movie and updates `movieDetails` property
    /// - Parameter movieId: ID of the movie to fetch details for
    func fetchMovieDetails(movieId: Int) {
        networkService.fetchMovieDetails(movieId: movieId)
            .receive(on: DispatchQueue.main)               // Ensure updates happen on main thread
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "fetch_movie_details_error".localized + error.localizedDescription  // Handle error by updating errorMessage
                }
            }, receiveValue: { [weak self] details in
                self?.movieDetails = details                // Update movieDetails with fetched data
            })
            .store(in: &cancellables)                       // Store subscription in cancellables
    }
}

