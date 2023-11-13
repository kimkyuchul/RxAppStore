//
//  SearchUseCase.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/13.
//

import Foundation

import RxSwift

protocol SearchUseCase: AnyObject {
    func fetchSearch(term: String, limit: Int)
}


final class SearchUseCaseImpl: SearchUseCase  {
    
    private let searchRepository: SearchRepository
    private let disposeBag: DisposeBag = .init()

     public init(searchRepository: SearchRepository) {
       self.searchRepository = searchRepository
     }
    
    var AppItem = BehaviorSubject<[AppItem]>(value: [])
    var error = PublishSubject<Error>()
    
    func fetchSearch(term: String, limit: Int) {
        searchRepository.fetchItunes(term: term, limit: limit)
            .subscribe { [weak self] result in
                switch result {
                case .success(let value):
                    self?.AppItem.onNext(value.results)
                case .failure(let error):
                    self?.error.onNext(error)
                }
            } onFailure: { [weak self] error in
                self?.error.onNext(error)
            }
            .disposed(by: disposeBag)
    }
}
