//
//  API.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import Foundation

enum API {
    
    static let newsAPIDomain = NewsAPIDomain
    static let newsDataDomain = NewsDataDomain
   
   
    // News
    case GetNewsApiEverything(keywords:String)
    case GetNewsData(keywords:String)
    ///end of mark

    var domain:String {
        let urlNewsAPI = API.newsAPIDomain
        let urlNewsData = API.newsDataDomain
        
        switch self {
        case .GetNewsApiEverything:
            return urlNewsAPI
        case .GetNewsData:
            return urlNewsData
        }
    }
   
    var route : String {
        var url = domain
        
        switch self {
        case .GetNewsApiEverything:
            url =  url.appending("v2/")
            return url
        case .GetNewsData:
            url =  url.appending("1/")
            return url
        }
        
    }
    
    var url : URL? {
        var url = route
        
        switch self {
            
        case .GetNewsApiEverything(let keywords):
            url =  url.appending("everything?q=\(keywords)&apiKey=\(NewsAPIKey)")
        case .GetNewsData(let keywords):
            url =  url.appending("news?apikey=\(NewsDataKey)&q=\(keywords)")
        }
        return URL.init(string: url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "")
    }
    
}

