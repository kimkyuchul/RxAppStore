//
//  SearchDTO.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/10.
//

import Foundation

struct SearchDTO: Decodable {
    let resultCount: Int
    let results: [AppItemDTO]
}

struct AppItemDTO: Decodable {
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
    
    enum CodingKeys: String, CodingKey {
        case artworkURL100 = "artworkUrl100"
        case trackName, primaryGenreName, averageUserRating, userRatingCount
        case trackViewURL = "trackViewUrl"
        case screenshotURLs = "screenshotUrls"
        case version, currentVersionReleaseDate, releaseNotes
        case appDescription = "description"
        case artistName, fileSizeBytes, languageCodesISO2A, contentAdvisoryRating, formattedPrice
    }
}

extension SearchDTO {
    func toDomain() -> Search {
        return Search(resultCount: resultCount, results: results.map { $0.toDomain() })
    }
}

extension AppItemDTO {
    func toDomain() -> AppItem {
        return AppItem(artworkURL100: artworkURL100, trackName: trackName, primaryGenreName: primaryGenreName, trackViewURL: trackViewURL, averageUserRating: averageUserRating, userRatingCount: userRatingCount, screenshotURLs: screenshotURLs, version: version, currentVersionReleaseDate: currentVersionReleaseDate, releaseNotes: releaseNotes, appDescription: appDescription, artistName: artistName, fileSizeBytes: fileSizeBytes, languageCodesISO2A: languageCodesISO2A, contentAdvisoryRating: contentAdvisoryRating, formattedPrice: formattedPrice)
    }
}
