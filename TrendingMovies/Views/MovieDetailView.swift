//
//  MovieDetailView.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MoviesViewModel
    let movieId: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.isLoading {
                ProgressView("Loading...".localized)
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if let movie = viewModel.movieDetails {
                ScrollView {
                    VStack(alignment: .center, spacing: 16) {
                        if let posterPath = movie.posterPath {
                            AsyncImageView(url: URL(string: Constants.Image.baseURL + posterPath)!)
                                .frame(width: 200, height: 300)
                                .cornerRadius(8)
                                .shadow(radius: 10)
                                .padding(.top)
                        }
                        Text(movie.releaseDate?.formattedYear ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(movie.overview)
                            .font(.body)
                            .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
                .navigationTitle(movie.title)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("No details available.".localized)
                    .font(.body)
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchMovieDetails(movieId: movieId)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MoviesViewModel(), movieId: 0)
    }
}
