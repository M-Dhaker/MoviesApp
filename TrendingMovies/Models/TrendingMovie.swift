//
//  TrendingMovie.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation

// Model representing a trending movie
struct TrendingMovie: Codable, Equatable {
    let id: Int
    let title: String
    let posterPath: String?

    // Coding keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }

    static func == (lhs: TrendingMovie, rhs: TrendingMovie) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.posterPath == rhs.posterPath
    }
}

/// Response model for trending movies API
struct MovieResponse: Codable {
    let results: [TrendingMovie]
}
