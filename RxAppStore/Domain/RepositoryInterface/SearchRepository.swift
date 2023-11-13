//
//  SearchRepository.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/13.
//

import Foundation

import RxSwift

protocol SearchRepository: AnyObject {
    func fetchItunes(term: String, limit: Int) -> Single<Result<Search, Error>>
}
