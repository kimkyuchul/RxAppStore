//
//  HTTPTask.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/13.
//

import Foundation

typealias QueryParameters = [URLQueryItem]

enum HTTPTask {
    case requestPlain
    case requestParameters(_ parameters: QueryParameters)
}
