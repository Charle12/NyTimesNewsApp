//
//  Article.swift
//  NyTimesNewsApp
//
//  Created by Admin on 12/12/20.
//

import Foundation

struct ArticlesData {
    var articles: [Article]?
}

extension ArticlesData: Parsable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<ArticlesData, ErrorResult> {
        if let results = dictionary[ArticleConstant.KEY_RESULT] as? [[String: Any]] {
            let articles = results.map({ Article(articleDict: $0)}).compactMap{$0}
            let meta = ArticlesData(articles: articles)
            return Result.success(meta)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse API response"))
        }
    }
}

struct Article {
    var name:String!
    var imageUrl:String?
    var publishedDate:Date?
    var byLineString:String?
    var abstractInfo:String?


    init?(articleDict:Dictionary <String, Any>) {
        guard let _ = articleDict[ArticleConstant.KEY_TITLE] as? String else {
            return nil
        }
        self.name = articleDict[ArticleConstant.KEY_TITLE] as? String
        self.byLineString = articleDict[ArticleConstant.KEY_BY_LINE] as? String
        self.abstractInfo = articleDict[ArticleConstant.KEY_ABSTRACT] as? String

        if let dateString = articleDict[ArticleConstant.KEY_PUBLISHED_DATE] as? String {
            self.publishedDate = Utils.getDateFromString(dateString: dateString) as Date?
        }
        if let media = articleDict[ArticleConstant.KEY_MEDIA] as? [Dictionary<String, Any>] {
            if let media_metaData = media.first?[ArticleConstant.KEY_META_DATA] as? [Dictionary<String, Any>] {
                self.imageUrl = media_metaData.first?[ArticleConstant.KEY_URL] as? String
            }
        }
    }
}

