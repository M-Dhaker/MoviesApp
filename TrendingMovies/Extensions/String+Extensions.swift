//
//  String+Localization.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation

extension String {
    /// Returns the localized version of the string.
    /// Uses NSLocalizedString to get the localized string for the current locale.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String: Identifiable {
    /// Conforms String to Identifiable protocol.
    /// Returns the string itself as its unique identifier.
    public var id: String { self }
}

extension String {
    /// Extracts and returns the year from a date string in the format "yyyy-MM-dd".
    /// - Returns: A string representing the year, or an empty string if the format is incorrect.
    var formattedYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return String(year)
    }
}

