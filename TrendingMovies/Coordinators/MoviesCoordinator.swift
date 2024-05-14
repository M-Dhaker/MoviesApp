//
//  MoviesCoordinator.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation
import SwiftUI

class MoviesCoordinator: ObservableObject {
    @Published var selectedMovieId: Int?
    private let viewModel = MoviesViewModel()

    func makeMoviesListView() -> some View {
        MoviesListView(viewModel: viewModel)
            .environmentObject(self)
    }

    func showMovieDetails(movieId: Int) {
        selectedMovieId = movieId
    }

    func movieDetailView(movieId: Int) -> some View {
        MovieDetailView(viewModel: viewModel, movieId: movieId)
    }
}
