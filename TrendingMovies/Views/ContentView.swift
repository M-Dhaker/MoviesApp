//
//  ContentView.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MoviesViewModel()

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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
