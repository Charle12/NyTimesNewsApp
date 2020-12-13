//
//  ArticleViewModelTests.swift
//  NyTimesNewsAppTests
//
//  Created by Admin on 12/14/20.
//

import XCTest

@testable import NyTimesNewsApp

class ArticleViewModelTests: XCTestCase {
    
    var viewModel : ArticleViewModel!
    var dataSource : GenericDataSource<ArticleCellViewModel>!
    fileprivate var service : MockServiceHelper!
    var viewModelWithArticles : ArticleViewModel!
    fileprivate var serviceWithArticle : MockServiceHelperWithArticle!

    
    override func setUp() {
        super.setUp()
        self.service = MockServiceHelper()
        self.serviceWithArticle = MockServiceHelperWithArticle()
        self.dataSource = GenericDataSource<ArticleCellViewModel>()
        self.viewModel = ArticleViewModel(service: service, dataSource: dataSource)
        self.viewModelWithArticles = ArticleViewModel(service: serviceWithArticle, dataSource: dataSource)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        // giving no service to a view model
        viewModel.service = nil
        // expected to not be able to fetch article
        viewModel.fetchArticles{ result in
            switch result {
            case .success(_) :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default:
                break
            }
        }
    }
    
    func testFetchArticles() {
        // expected completion to succeed
        viewModelWithArticles.fetchArticles { result in
            switch result {
            case .failure(_) :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default:
                break
            }
        }
    }
    
    func testFetchNoArticles() {
        // expected completion to fail
        viewModel.fetchArticles { result in
            switch result {
            case .success(_) :
                XCTAssert(false, "ViewModel should not be able to fetch ")
            default:
                break
            }
        }
    }
}

fileprivate class MockServiceHelper : ServiceHelperProtocol {
    var newsData: ArticlesData?
    func fetchArticles(_ completion: @escaping ((Result<ArticlesData, ErrorResult>) -> Void)) {
        if let newsData = newsData {
            completion(Result.success(newsData))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No NewsData")))
        }
    }
}

fileprivate class MockServiceHelperWithArticle : ServiceHelperProtocol {
    var newsData: ArticlesData? = ArticlesData(articles: [Article(articleDict: ["title":"Dummy Article"])!])
    func fetchArticles(_ completion: @escaping ((Result<ArticlesData, ErrorResult>) -> Void)) {
        if let newsData = newsData {
            completion(Result.success(newsData))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No NewsData")))
        }
    }
}
