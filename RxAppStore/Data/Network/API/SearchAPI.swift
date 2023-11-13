//
//  SearchAPI.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/13.
//

import Foundation

enum SearchAPI {
    case fetchItunes(term: String, country: String = "KR", media: String = "software", lang: String = "ko_KR", limit: Int)
}

extension SearchAPI: EndPointType {
    var path: String {
        return "/search"
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .fetchItunes:
            return HTTPMethod.get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .fetchItunes(term: let term, country: let country, media: let media, lang: let lang, limit: let limit):
            return .requestParameters([
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "country", value: country),
                URLQueryItem(name: "media", value: media),
                URLQueryItem(name: "lang", value: lang),
                URLQueryItem(name: "limit", value: "\(limit)")
            ])
        }
    }
}
