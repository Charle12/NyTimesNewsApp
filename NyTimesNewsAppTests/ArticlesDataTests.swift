//
//  ArticlesDataTests.swift
//  NyTimesNewsAppTests
//
//  Created by Admin on 12/14/20.
//

import XCTest

@testable import NyTimesNewsApp

let kSampleArticleTitle = "Trump administration officials passed when Pfizer offered months ago to sell the U.S. more vaccine doses."
let kSampleArticleCount = 1
let kSampleArticlePubDate = "2020-12-07"

class ArticlesDataTests: XCTestCase {
    
    func testParseEmptyArticlesData() {
        
        // giving empty data
        let data = Data()
        
        // giving completion after parsing
        // expected valid NewsData with   valid Article data
        let completion : ((Result<ArticlesData, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testParseArticlesData() {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "sample") else {
            XCTAssert(false, "Can't get data from sample.json")
            return
        }
        
        // giving completion after parsing
        // expected valid converter with valid data
        let completion : ((Result<ArticlesData, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid newsData")
            case .success(let newsData):
                
                XCTAssertEqual(newsData.articles?.count, kSampleArticleCount, "Expected \(kSampleArticleCount)")
                XCTAssertEqual(newsData.articles?.first?.name, kSampleArticleTitle, "Expected \(kSampleArticleTitle)")
                if let date = newsData.articles?.first?.publishedDate
                {
                    XCTAssertEqual(Utils.getStringFromDate(date: date), kSampleArticlePubDate, "Expected \(kSampleArticlePubDate)")
                }
            }
        }
        
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testWrongKeyArticlesData() {
        
        // giving a wrong dictionary
        let dictionary = ["test" : 123 as AnyObject]
        
        // expected to return error of NewsData
        let result = ArticlesData.parseObject(dictionary: dictionary)
        
        switch result {
        case .success(_):
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
}

extension FileManager {
    
    static func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: ArticlesDataTests.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        return nil
    }
}

