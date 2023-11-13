//
//  BaseErrorDTO.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/10.
//

import Foundation

struct BaseErrorDTO: Decodable {
    let errorMessage: String
    let queryParameters: String
}
