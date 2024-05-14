//
//  MovieDetailView.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MoviesViewModel
    let movieId: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let movie = viewModel.movieDetails {
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                if let posterPath = movie.posterPath {
                    AsyncImageView(url: URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)!)
                        .frame(width: 200, height: 300)
                }
                Text(movie.overview)
                    .font(.body)
            } else {
                Text("Loading...".localized)
                    .font(.body)
            }
        }
        .padding()
        .navigationTitle("Movie Details".localized)
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
