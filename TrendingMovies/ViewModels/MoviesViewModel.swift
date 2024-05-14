//
//  MoviesViewModel.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation
import Combine

import Foundation
import Combine

/// ViewModel to manage fetching and storing movie data
class MoviesViewModel: ObservableObject {
    @Published var trendingMovies: [TrendingMovie] = []    // Published property for trending movies
    @Published var movieDetails: MovieDetail?              // Published property for movie details
    @Published var errorMessage: String?                   // Published property for error messages
    @Published var isLoading: Bool = false                 // Published property for loading state

    private var cancellables = Set<AnyCancellable>()       // Set to store Combine subscriptions
    private let networkService: NetworkServiceProtocol     // Network service to fetch data

    private var currentPage = 1                            // Track current page for pagination
    private var canLoadMorePages = true                    // Flag to check if more pages can be loaded

    /// Initializer with dependency injection for network service
    /// - Parameter networkService: Protocol for network service, default is NetworkService.shared
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }

    /// Fetches trending movies and updates `trendingMovies` property
    func fetchTrendingMovies() {
        guard !isLoading, canLoadMorePages else { return }

        isLoading = true
        networkService.fetchTrendingMovies(page: currentPage)
            .receive(on: DispatchQueue.main)               // Ensure updates happen on main thread
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = "fetch_trending_movies_error".localized + error.localizedDescription  // Handle error by updating errorMessage
                }
            }, receiveValue: { [weak self] movies in
                self?.trendingMovies.append(contentsOf: movies) // Append new movies to the list
                self?.currentPage += 1
                self?.canLoadMorePages = !movies.isEmpty       // Check if more pages can be loaded
            })
            .store(in: &cancellables)                       // Store subscription in cancellables
    }

    /// Fetches details of a specific movie and updates `movieDetails` property
    /// - Parameter movieId: ID of the movie to fetch details for
    func fetchMovieDetails(movieId: Int) {
        isLoading = true
        networkService.fetchMovieDetails(movieId: movieId)
            .receive(on: DispatchQueue.main)               // Ensure updates happen on main thread
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = "fetch_movie_details_error".localized + error.localizedDescription  // Handle error by updating errorMessage
                }
            }, receiveValue: { [weak self] details in
                self?.movieDetails = details                // Update movieDetails with fetched data
            })
            .store(in: &cancellables)                       // Store subscription in cancellables
    }
}
