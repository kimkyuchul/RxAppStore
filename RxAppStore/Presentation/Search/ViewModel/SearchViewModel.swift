//
//  SearchViewModel.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/10.
//

import Foundation

import RxSwift
import RxRelay

final class SearchViewModel: ViewModelType {
    
    private let searchUseCase = SearchUseCaseImpl(searchRepository: SearchRepositoryImpl(iTunesNetwork: ITunesNetworking()))
    var disposeBag: DisposeBag = .init()
    
    struct Input {
        let searchButtonTapped: Observable<Void>
    }
    
    struct Output {
        let appInfo: BehaviorRelay<[AppItem]>
        let error: PublishRelay<Error>
    }
    
    func transform(input: Input) -> Output {
        let appInfo = BehaviorRelay<[AppItem]>(value: [])
        let error = PublishRelay<Error>()
        
        input.searchButtonTapped
            .subscribe(with: self) { owner , _ in
                owner.searchUseCase.fetchSearch(term: "todo", limit: 10)
            }
            .disposed(by: disposeBag)
        
        searchUseCase.AppItem
            .bind(to: appInfo)
            .disposed(by: disposeBag)
        
        searchUseCase.error
            .bind(to: error)
            .disposed(by: disposeBag)
        
        
        return Output(appInfo: appInfo, error: error)
    }
}
