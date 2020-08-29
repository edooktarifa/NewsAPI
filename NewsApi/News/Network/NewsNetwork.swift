//
//  NewsNetwork.swift
//  NewsApi
//
//  Created by Lawencon on 27/08/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

enum NewsNetwork: URLRequestConvertible {
    case postNews(q: String, from: String, sortBy: String, apiKey: String)
    
    static let baseUrl = NetworkApps.baseUrl()
    
    var method: HTTPMethod{
        switch self {
        case .postNews(_, _, _, _):
            return .get
        }
    }
    
    var path: String{
        switch self {
        case .postNews(_, _, _, _):
            return "/v2/everything"
        }
    }
    
    var param : [String: Any]{
        switch self {
        case .postNews(let q, let from, let sortBy, let apiKey):
            return ["q": q, "from": from, "sortBy": sortBy, "apiKey": apiKey]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url: URL?
        var urlRequest: URLRequest?
        url = try NewsNetwork.baseUrl.asURL()
        urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
        urlRequest?.httpMethod = method.rawValue
        urlRequest = try URLEncoding.default.encode(urlRequest!, with: param)
        
        return urlRequest!
    }
}


public struct NetworkApps{
    public static func baseUrl() -> String{
        return "http://newsapi.org"
    }
}
