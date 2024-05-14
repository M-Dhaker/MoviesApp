//
//  ContentView.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesViewModel
    @EnvironmentObject var coordinator: MoviesCoordinator

    var body: some View {
        NavigationView {
            List(viewModel.trendingMovies, id: \.id) { movie in
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    if let posterPath = movie.posterPath {
                        AsyncImageView(url: URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)!)
                            .frame(width: 100, height: 150)
                    }
                }
                .onTapGesture {
                    coordinator.showMovieDetails(movieId: movie.id)
                }
            }
            .navigationTitle("trending_movies".localized)
            .onAppear {
                viewModel.fetchTrendingMovies()
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(title: Text("error".localized),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("ok".localized)))
            }
            .background(
                NavigationLink(
                    destination: coordinator.movieDetailView(movieId: coordinator.selectedMovieId ?? 0),
                    isActive: Binding<Bool>(
                        get: { coordinator.selectedMovieId != nil },
                        set: { _ in coordinator.selectedMovieId = nil }
                    ),
                    label: { EmptyView() }
                )
            )
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesViewModel())
            .environmentObject(MoviesCoordinator())
    }
}
