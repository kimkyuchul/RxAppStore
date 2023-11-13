//
//  AppItem.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/13.
//

import Foundation

struct AppItem {
    let artworkURL100: String
    let trackName: String
    let primaryGenreName: String
    let trackViewURL: String
    let averageUserRating: Double
    let userRatingCount: Int
    let screenshotURLs: [String]
    let version: String
    let currentVersionReleaseDate: String
    let releaseNotes: String
    let appDescription: String
    let artistName: String
    let fileSizeBytes: String
    let languageCodesISO2A: [String]
    let contentAdvisoryRating: String
    let formattedPrice: String
}
