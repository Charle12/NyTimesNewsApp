//
//  ServiceHelper.swift
//  NyTimesNewsApp
//
//  Created by Admin on 12/13/20.
//

import Foundation

// API URLS
let APIKey = "vQAVT7cAVdGwUZx0ZiSOGoVvuEANvAR7"
let kAPIPeriods:Int = 7
let API_BASE_URL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/"
let NEWS_API_URL = API_BASE_URL + "/\(kAPIPeriods)" + ".json?api-key=\(APIKey)"


protocol ServiceHelperProtocol : class {
    func fetchArticles(_ completion: @escaping ((Result<ArticlesData, ErrorResult>) -> Void))
}

final class ServiceHelper : GenericAPIClient, ServiceHelperProtocol {
    
    static let shared = ServiceHelper()
    
    let apiUrlStr = NEWS_API_URL
    var task : URLSessionTask?
    
    func fetchArticles(_ completion: @escaping ((Result<ArticlesData, ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchArticles()
        task = APIClient().loadData(urlString: apiUrlStr, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchArticles() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
