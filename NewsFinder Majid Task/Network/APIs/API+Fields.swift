//
//  API+Fields.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import Foundation
import Alamofire

extension API {
    
    //MARK: For HTTPMethod
    var method : HTTPMethod {
        switch self {
            
        default:
            return HTTPMethod.get
        }
    }
    
    //MARK: For Headers
    var header : HTTPHeaders? {
        
        switch self {

        default:
            return ["Content-type": "application/json; charset=UTF-8"]
        }
    }
    
    //MARK: For Body Requests
    var parameter : [String:Any]? {
        switch self {
            
        default:
            return nil
        
        }
    }

}
