//
//  APIService.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 26/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Reachability

enum ApiStatusType: Int {
    
    case apiSucceed
    case netWorkIssue
    case apiIssue
    case apiParsingIssue
    case apiEncodingIssue
    case none
    
}

struct ErrorDescriptionKeys {
    
    static let titleKey = "title"
    static let subTitleKey = "subtitle"
    static let statusCodeKey = "statusCode"
    
}


class APIService {
    
    let reachability = Reachability()
    
    init() { }
    
    func loadDataWith(urlString: String, onSuccess success: @escaping (_ data: Data, _ apiStatusCode: ApiStatusType) -> Void, onFailure failure: @escaping (_ error: Error?, _ apiStatusCode: ApiStatusType) -> Void) {
        
        if (reachability?.connection == .cellular || reachability?.connection == .wifi) {
            
            guard let url = URL(string: urlString) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                //                let httpResponse = response as? HTTPURLResponse
                //
                //                if let statusCode = httpResponse?.statusCode, statusCode != 200 {
                //                    let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                //                    if let errorResponseDictionary = json as? [String: Any] {
                //                        dict[ErrorDescriptionKeys.titleKey] = errorResponseDictionary["message"] as? String
                //                    }
                //                    failure(nil, dict)
                //                    return
                //                }
                
                if let errorValue = error {
                    failure(errorValue, ApiStatusType.apiIssue)
                } else if let data = data {
                    success(data, ApiStatusType.apiSucceed)
                } else {
                    failure(nil, ApiStatusType.netWorkIssue)
                }
                
            }
            task.resume()
            
            /*
             let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
             request.httpMethod = "GET"
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             
             let session = URLSession.shared
             let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
             
             if (error != nil) {
             print(error)
             } else {
             let httpResponse = response as? HTTPURLResponse
             print(httpResponse)
             
             var dict: Dictionary = Dictionary<String,String>()
             
             dict[ErrorDescriptionKeys.statusCodeKey] = (httpResponse?.statusCode != nil) ? "\(String(describing: (httpResponse?.statusCode)!))" : ""
             
             if let statusCode = httpResponse?.statusCode, statusCode != 200 {
             let json = try? JSONSerialization.jsonObject(with: data!, options: [])
             if let errorResponseDictionary = json as? [String: Any] {
             dict[ErrorDescriptionKeys.titleKey] = errorResponseDictionary["message"] as? String
             }
             failure(nil, dict)
             return
             }
             
             if let errorValue = error {
             dict[ErrorDescriptionKeys.titleKey] = errorValue.localizedDescription
             dict[ErrorDescriptionKeys.subTitleKey] = "API calling Issue"
             failure(errorValue, dict)
             } else if let data = data {
             success(data, dict)
             } else {
             failure(nil, dict)
             }
             
             }
             
             })
             
             dataTask.resume()
             */
            
        } else {
            failure(nil, ApiStatusType.netWorkIssue)
        }
        
    }
    
}

