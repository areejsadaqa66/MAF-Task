//
//  Helper.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import Foundation

func convertDate(_ dateString: String, dateFormat: String, APIDateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String{
    
    let formatter = DateFormatter()
    formatter.dateFormat = APIDateFormat
    if APIDateFormat == "MMM d, yyyy"{ // to fix the history page issue in arabic always send date in en
        formatter.locale =  Locale(identifier: "en_US_POSIX")
    }
    else{
        formatter.locale =  Locale(identifier: "en_US_POSIX")
    }
    let date = formatter.date(from: dateString)

    formatter.dateFormat = dateFormat
    let formattedDate = formatter.string(from: date ?? Date())

    return formattedDate
}


extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
