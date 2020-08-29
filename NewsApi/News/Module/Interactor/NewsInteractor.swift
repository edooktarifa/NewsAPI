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

class NewsInteractor: NewsPresenterToInteractorProtocol{
    func fetchNews(q: String, from: String, sortBy: String, apiKey: String) {
        Alamofire.request(NewsNetwork.postNews(q: q, from: from, sortBy: sortBy, apiKey: apiKey)).responseJSON { (response) in
            
            print(response)
            
            switch response.result{
            case .success:
                guard let data = Mapper<NewsModel>().map(JSONObject: response.result.value) else {return}
                self.presenter?.newsListFethedSucces(data: [data])
            case .failure(let error):
                self.presenter?.newsListFetchedFailed(message: error.localizedDescription)
            }
        }
    }
    
    var presenter: NewsInteractorToPresenterProtocol?
    
    
}
