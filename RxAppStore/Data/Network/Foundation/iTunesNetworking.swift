//
//  iTunesNetworking.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/12.
//

import Foundation

import RxSwift

final class ITunesNetworking {
    
    func request<T: Decodable>(endPoint: EndPointType, type: T.Type) -> Single<Result<T, Error>> {
        
        guard let urlRequest = asURLRequest(endPoint: endPoint) else {
            return Single.just(Result<T, Error>.failure(ITunesNetworkError.urlError))
        }
        
        return URLSession.shared.rx.response(request: urlRequest)
            .handleResponse()
            .asSingle()
            
        
//        return URLSession.shared.rx.data(request: urlRequest)
//            .handleResponse()
//            .asSingle()
    }
}

extension ObservableType where Element == (response: HTTPURLResponse, data: Data) {
    func handleResponse<T: Decodable>() -> Observable<Result<T, Error>> {
        return flatMap { element in
            let jsonDecoder = JSONDecoder()
            
            if (200...299) ~= element.0.statusCode {
                let decodedData = try jsonDecoder.decode(T.self, from: element.1)
                return Observable.just(Result<T, Error>.success(decodedData))
            }
            
            if let error = try? jsonDecoder.decode(BaseErrorDTO.self, from: element.1) {
                return Observable.just(Result<T, Error>.failure(ITunesNetworkError.serverError(message: error.errorMessage)))
            }
            
            return Observable.just(Result<T, Error>.failure(ITunesNetworkError.unknown))
        }
    }
}

extension ObservableType where Element == Data {
    func handleResponse<T: Decodable>() -> Observable<Result<T, Error>> {
        return flatMap { element in
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: element)
                return Observable.just(Result<T, Error>.success(decodedData))
            } catch {
                return Observable.just(Result<T, Error>.failure(error))
            }
        }
        .catch { error in
            return Observable.just(Result<T, Error>.failure(error))
        }
    }
}

private extension ITunesNetworking {
    func asURLRequest(endPoint: EndPointType) -> URLRequest? {
         guard var components = URLComponents(string: endPoint.baseURL) else {
             return nil
         }
         
         components.path += endPoint.path
         
         switch endPoint.task {
         case .requestPlain:
             break
         case .requestParameters(let parameters):
             components.queryItems = parameters
         }
         
         guard let url = components.url else {
             return nil
         }
         
         var urlRequest = URLRequest(url: url)
         urlRequest.httpMethod = endPoint.method.rawValue
         
         
         return urlRequest
     }
}
