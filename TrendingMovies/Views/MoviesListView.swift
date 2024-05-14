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
            VStack {
                if viewModel.isLoading && viewModel.trendingMovies.isEmpty {
                    ProgressView("Loading...".localized)
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List(viewModel.trendingMovies, id: \.id) { movie in
                        HStack(alignment: .top, spacing: 10) {
                            if let posterPath = movie.posterPath {
                                AsyncImageView(url: URL(string: Constants.Image.baseURL + posterPath)!)
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(.headline)
                                Text(movie.releaseDate?.formattedYear ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .contentShape(Rectangle())
                        .onAppear {
                            if movie == viewModel.trendingMovies.last {
                                viewModel.fetchTrendingMovies()
                            }
                        }
                        .onTapGesture {
                            coordinator.showMovieDetails(movieId: movie.id)
                        }
                    }
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
