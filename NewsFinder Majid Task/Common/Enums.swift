//
//  HomePresenter+Extension.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import Foundation

enum Countries:Int, CaseIterable {
    case us = 0
    case ae
    case jo
    
    var name:String {
        switch self {
        case .us:
            return "united states of america"
        case .ae:
            return "united arab emirates"
        case .jo:
            return "jordan"
        }
    }
    
    var code:String{
        switch self {
        case .us:
            return "US"
        case .ae:
            return "AE"
        case .jo:
            return "JO"
        }
    }
}

enum ProvidersType: Int, CaseIterable {
    case NewsAPI
    case NewsData
}

enum FilterType:Int, CaseIterable {
    case Country
    case Categories
    
    var name:String {
        switch self {
        case .Country:
            return "Country"
        case .Categories:
            return "Category"
        }
    }
}

enum Categories:Int,CaseIterable {
    case Sports = 0
    case Business
    case Health
    
    var name:String {
        switch self {
            
        case .Sports:
            return "Sports"
        case .Business:
            return "Business"
        case .Health:
            return "Health"
        }
    }
}

