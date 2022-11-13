//
//  APIClient+Fetching.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import Foundation
import UIKit


func fetchGenericData<T: Decodable>(api: API, compliation: @escaping((T?)->())){
    
    APIClient.getRequest(api: api) { (response: T? , errors) in
        
        guard errors == nil else{return}
        guard let response = response  else {return}
        do {
            compliation(response)
        }catch _ { print("Failed to decode JSON")
            ///Show Error Dialog
        }
    }
    
}

