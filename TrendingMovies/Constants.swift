//
//  Constants.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation

struct Constants {
    struct API {
        static let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
        static let baseURL = "https://api.themoviedb.org/3"
        static let trendingMoviesEndpoint = "/discover/movie"
        static let movieDetailsEndpoint = "/movie/"
    }
    struct Image {
        static let baseURL = "https://image.tmdb.org/t/p/w500"
    }

}
