//
//  NewsDataSource.swift
//  NyTimesNewsApp
//
//  Created by Admin on 12/12/20.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: GenericValue<[T]> = GenericValue([])
}

class ArticleDataSource : GenericDataSource<ArticleCellViewModel>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell configuration
        let cell = tableView.dequeueReusableCell(withIdentifier: kArticleCellID, for: indexPath) as! ArticleTVC
        cell.selectionStyle = .none
        cell.configCellUI()

        // Set cell data
        let articleCellVM = self.data.value[indexPath.row]
        cell.articleCellVM = articleCellVM
        return cell
    }
}

