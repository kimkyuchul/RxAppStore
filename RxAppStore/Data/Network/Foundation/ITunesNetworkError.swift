//
//  ITunesNetworkError.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/13.
//

import Foundation

enum ITunesNetworkError: Error {
    case urlError
    case serverError(message: String)
    case unknown
}
