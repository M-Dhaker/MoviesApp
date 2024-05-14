//
//  TrendingMovie.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation
/// Response model for trending movies API
struct MovieResponse: Codable {
    let results: [TrendingMovie]
}

/// Model representing a trending movie
struct TrendingMovie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    
    // Coding keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}
