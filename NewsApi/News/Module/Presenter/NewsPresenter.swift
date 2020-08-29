//
//  NewsPresenter.swift
//  NewsApi
//
//  Created by Lawencon on 27/08/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit

class NewsPresenter: NewsViewToPresenterProtocol {
    var view: NewsPresenterToViewProtocol?
    
    var interactor: NewsPresenterToInteractorProtocol?
    
    var router: NewsPresenterToWireframeProtocol?
    
    func startFetching(data: newsListRequest.newsParam) {
        interactor?.fetchNews(q: data.q ?? "", from: data.from ?? "", sortBy: data.sortBy ?? "", apiKey: data.apiKey ?? "")
    }
    
    func moveToDetail(from view: UIViewController) {
        
    }
}

extension NewsPresenter: NewsInteractorToPresenterProtocol{
    func newsListFethedSucces(data: [NewsModel]) {
        view?.showData(data: data)
    }
    
    func newsListFetchedFailed(message: String) {
        view?.displayError(message: message)
    }
    
    func moveToDetail() {
        
    }
    
    
}
