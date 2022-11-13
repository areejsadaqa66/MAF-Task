//
//  HomePresenter.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import Foundation

protocol HomeViewPresenter:NSObjectProtocol{
    func newsAPIFailed(_ error:String)
    func newsDataFailed(_ error:String)
    func showData(_ newsAPIResponse: NewsAPIResponse, _ newsDataResponse: NewsDataResponse)
    func filterHandler(notification: NSNotification)
}

final class HomePresenter {
    
    let dispatchGroup = DispatchGroup()
    var newsAPIResponse:NewsAPIResponse?
    var newsDataResponse:NewsDataResponse?
    var newsAPIArticles:[Article]?
    var newsDataResults:[Result]?
    var newsAPIFilteredArticles:[Article]?
    var newsDataFilteredResults:[Result]?
    
    fileprivate weak var viewPresenter:HomeViewPresenter?
    init(_ view:HomeViewPresenter) {
        viewPresenter = view
        NotificationCenter.default.addObserver(self, selector: #selector(filterHandler(notification:)), name: selectedFilter, object: nil)
    }
    
    func getHomeRequests() {
        self.getNewsAPI(keywords: "tesla")
        self.getNewsData(keywords: "cryptocurrency")
        
        dispatchGroup.notify(queue: .main) {
            if let newsAPIResponse = self.newsAPIResponse,
               let newsDataResponse = self.newsDataResponse{
                self.newsAPIArticles = newsAPIResponse.articles
                self.newsDataResults = newsDataResponse.results
                self.newsAPIFilteredArticles = newsAPIResponse.articles
                self.newsDataFilteredResults = newsDataResponse.results
                self.viewPresenter?.showData(newsAPIResponse, newsDataResponse)
            }
            print("Finished all requests.")
        }
    }
    
    func getNewsAPI(keywords: String) {
        dispatchGroup.enter()
        fetchGenericData(api: API.GetNewsApiEverything(keywords: keywords)) { [weak self] (response: NewsAPIResponse?) in
            guard let vc = self else {return}
            if let response = response{
                if response.status == "ok"{
                    self?.newsAPIResponse = response
                    vc.dispatchGroup.leave()
                } else {
                    vc.viewPresenter?.newsAPIFailed(response.message ?? "")
                }
            }
        }
    }
    
    func getNewsData(keywords: String) {
        dispatchGroup.enter()
        fetchGenericData(api: API.GetNewsData(keywords: keywords)) { [weak self] (response: NewsDataResponse?) in
            guard let vc = self else {return}
            if let response = response{
                if response.status == "success"{
                    self?.newsDataResponse = response
                    vc.dispatchGroup.leave()
                } else {
                    vc.viewPresenter?.newsDataFailed(response.results?.first?.message ?? "")
                }
            }
        }
    }
    
    @objc func filterHandler(notification: NSNotification){
        self.viewPresenter?.filterHandler(notification:notification)
    }
    
    func resetFilter() {
        newsAPIFilteredArticles = newsAPIArticles
        newsDataFilteredResults = newsDataResults
    }
    
}
