//
//  NewsModel.swift
//  NewsApi
//
//  Created by Lawencon on 27/08/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class NewsModel : Mappable {
    var status : String?
    var totalResults : Int?
    var articles : [Articles]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        totalResults <- map["totalResults"]
        articles <- map["articles"]
    }
    
}

class Articles : Mappable {
    var source : Source?
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        source <- map["source"]
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
    }
    
}


class Source : Mappable {
    var id : String?
    var name : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
    }
    
}

struct newsListRequest {
    struct newsParam {
        var q: String?
        var from: String?
        var sortBy: String?
        var apiKey: String?
    }
}

