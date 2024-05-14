//
//  String+Localization.swift
//  TrendingMovies
//
//  Created by Dhaker Trimech on 14/05/2024.
//

import Foundation

extension String {
    /// Returns the localized version of the string.
    /// - Returns: Localized string.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String: Identifiable {
    public var id: String { self }
}
