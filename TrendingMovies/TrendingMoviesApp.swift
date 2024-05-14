//
//  TrendingMoviesApp.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import SwiftUI

@main
struct TrendingMoviesApp: App {
    @StateObject private var coordinator = MoviesCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.makeMoviesListView()
        }
    }
}
