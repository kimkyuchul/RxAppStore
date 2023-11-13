//
//  EndPointType.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/13.
//

import Foundation

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
}

extension EndPointType {
    var baseURL: String {
        return "https://itunes.apple.com"
    }
}
