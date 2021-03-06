//
//  NewsProtocol.swift
//  NewsApi
//
//  Created by Lawencon on 27/08/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit

protocol NewsPresenterToViewProtocol: class {
    func showData(data: [NewsModel])
    func displayError(message: String)
}

protocol NewsPresenterToWireframeProtocol: class {
    static func createModule(news: NewsViewController)
}

protocol NewsInteractorToPresenterProtocol: class {
    func newsListFethedSucces(data: [NewsModel])
    func newsListFetchedFailed(message: String)
}

protocol NewsPresenterToInteractorProtocol: class {
    func fetchNews(q: String, from: String, sortBy: String, apiKey: String)
    var presenter: NewsInteractorToPresenterProtocol? {get set}
}

protocol NewsViewToPresenterProtocol: class {
    var view: NewsPresenterToViewProtocol? {get set}
    var interactor: NewsPresenterToInteractorProtocol? {get set}
    var router: NewsPresenterToWireframeProtocol? {get set}
    
    func startFetching(data: newsListRequest.newsParam)
}

