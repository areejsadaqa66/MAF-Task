//
//  NewsDataResponse.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import Foundation
// MARK: - NewsDataResponse
struct NewsDataResponse: Codable {
    let status: String?
    let totalResults: Int?
    let results: [Result]?
    let nextPage: Int?
}

// MARK: - Result
struct Result: Codable {
    let title: String?
    let link: String?
    let keywords, creator: [String]?
    let videoURL: String?
    let resultDescription, content: String?
    let pubDate: String?
    let imageURL: String?
    let sourceID: String?
    let country: [String]?
    let category: [String]?
    let language: String?
    let code:String?
    let message:String?
    
    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case videoURL = "video_url"
        case resultDescription = "description"
        case content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case country, category, language
        case code, message
    }
}
