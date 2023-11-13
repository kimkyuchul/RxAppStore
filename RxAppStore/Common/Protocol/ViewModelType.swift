//
//  ViewModelType.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/10.
//

import Foundation

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
    var disposeBag: DisposeBag { get }
}
