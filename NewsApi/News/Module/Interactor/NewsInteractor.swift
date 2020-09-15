//
//  NewsInteractor.swift
//  NewsApi
//
//  Created by Lawencon on 27/08/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import RxSwift


class NewsInteractor: NewsPresenterToInteractorProtocol{
    
    var presenter: NewsInteractorToPresenterProtocol?
    private var disposeBag = DisposeBag()
    
    func fetchNews(q: String, from: String, sortBy: String, apiKey: String) {
        NetworkApiServices.fetchArticles(q: q, from: from, sortBy: sortBy, apiKey: apiKey).subscribe(
            onNext: { (news) in
            
            self.presenter?.newsListFethedSucces(data: news)
        }, onError: { (error) in
            self.presenter?.newsListFetchedFailed(message: error.localizedDescription)
        })
            .disposed(by: disposeBag)
    }
}
