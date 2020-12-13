//
//  ArticleCellViewModel.swift
//  NyTimesNewsApp
//
//  Created by Admin on 12/12/20.
//

import Foundation

struct ArticleCellViewModel
{
    var title:String!
    var imageUrl:String?
    var publishedDate:Date!
    var byLineString:String?
    var captionInfo:String?
    
    init(article:Article)
    {
        self.title = article.name
        self.imageUrl = article.imageUrl
        self.publishedDate = article.publishedDate
        self.byLineString = article.byLineString
        self.captionInfo = article.abstractInfo
    }
}
