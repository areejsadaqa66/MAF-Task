//
//  APIClient.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import Foundation
import Alamofire

class APIClient {
    
    static func getRequest<T: Decodable>(api:API, completion:@escaping (T?,Error?)->()) {
        
        
        /// If validation fails, subsequent calls to response handlers will have an associated error.
        guard let url = api.url else {
            print("request failed: Can't find URL")
            return
        }
        
        AF.request(url, method: api.method , parameters: api.parameter, headers: api.header).validate().responseData { (response) in
            
            do {
                if response.response?.statusCode == 401 {
                    //  call refresh token
                }
                
                if !(200...299).contains(response.response?.statusCode ?? 0) {
                    
                    completion(nil,response.error)
                    print("Error -----> \(String(describing: response.error) ) statusCode -----> \(String(describing: response.response?.statusCode))) statusCode -----> \(String(describing: response.response?.statusCode))")
                } else {
                    if let data = response.data {
                        let obj = try JSONDecoder().decode(T.self, from: data)
                        completion(obj,response.error)
                    }
                    print("\n\n\nRequesting\n============\n\(api.url?.absoluteString ?? "")\n============\nAND PARAMS\n============\n\(api.parameter ?? [:])\n============\nAND HEADERS\n============\n\(api.header ?? [:])\n============\n\n\n")
                    
                    guard let preetyResponse = response.data?.prettyPrintedJSONString else {return}
                    print("===========\n\nResponse\n \(preetyResponse)\n\n===========")
                    
                }
            } catch(let error) {
                completion(nil,error)
                print("Error -----> \(String(describing: error) ) statusCode -----> \(String(describing: response.response?.statusCode))) statusCode -----> \(String(describing: response.response?.statusCode))")
            }
            
        }
        
    }
    
}
