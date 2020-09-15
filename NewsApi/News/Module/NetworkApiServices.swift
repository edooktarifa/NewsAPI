//
//  NetworkApiServices.swift
//  NewsApi
//
//  Created by Lawencon on 01/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift
import ObjectMapper

class NetworkApiServices {
    static func fetchArticles(q: String, from: String, sortBy: String, apiKey: String) -> Observable<[NewsModel]>{
        return Observable<[NewsModel]>.create{
            observer -> Disposable in
            
            let request = Alamofire.request(NewsNetwork.postNews(q: q, from: from, sortBy: sortBy, apiKey: apiKey)).validate().responseJSON{

                response in

                switch response.result{
                case .success:
                    guard let data = Mapper<NewsModel>().map(JSONObject: response.result.value) else {return}
                    observer.onNext([data])
                    observer.onCompleted()

                case .failure(let error):
                    observer.onError(error)

                }
            }
            
//                .responseObject(completionHandler: { (response: DataResponse<NewsModel>) in
//                    
//                    switch response.result{
//                    case .success(let news):
//                        observer.onNext([news])
//                        observer.onCompleted()
//                    case .failure(let error):
//                        observer.onError(error)
//                    }
//                })
//            
//            return Disposables.create(with: {
//                request.cancel()
//            })
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
}
