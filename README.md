# MoviesApp
MoviesApp is a simple iOS application that displays a list of trending movies and shows detailed information for each movie. The app is built using SwiftUI and Combine, following the MVVM-C architecture pattern. It fetches movie data from The Movie Database (TMDb) API.

## Features

- Display a list of trending movies
- View detailed information about a selected movie
- Pagination support to load more movies as the user scrolls
- Localized strings for multiple languages
- Async image loading with placeholder
- Centralized configuration for URLs and API keys

## Architecture

The app follows the MVVM-C (Model-View-ViewModel-Coordinator) architecture pattern using SwiftUI and Combine.

## Setup

1. Clone the repository
2. Open `TrendingMovies.xcodeproj` in Xcode
3. Build and run the app on a simulator or device

## Configuration

The URLs and API keys are stored in `Constants.swift` for easy maintenance and modification

## Dependencies

No external dependencies are used. The app is built using native SwiftUI and Combine

## Tests

Unit tests are included to verify the functionality of the ViewModel and network layer. Tests cover fetching trending movies, fetching movie details, and error handling
