//
//  SearchRepositoryImpl.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/10.
//

import Foundation

import RxSwift

final class SearchRepositoryImpl: SearchRepository {
    
    private let iTunesNetwork: ITunesNetworking
    
    init(iTunesNetwork: ITunesNetworking) {
        self.iTunesNetwork = iTunesNetwork
    }
    
    func fetchItunes(term: String, limit: Int) -> Single<Result<Search, Error>> {
        return iTunesNetwork.request(endPoint: SearchAPI.fetchItunes(term: term, limit: limit), type: SearchDTO.self)
            .flatMap { result in
                Single.just(result.map { $0.toDomain() })
            }
    }
}
