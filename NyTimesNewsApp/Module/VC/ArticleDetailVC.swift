//
//  PopularArticlesDetailVC.swift
//  NyTimesNewsApp
//
//  Created by Admin on 12/12/20.
//

import UIKit

import SDWebImage

class ArticleDetailVC: UIViewController {

    @IBOutlet weak var detailLabel:UILabel!
    @IBOutlet weak var articleDetailIcon:UIImageView!

    var detailNews:String?
    var detailNewsImageUrl:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = detailNews
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadArticleImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        articleDetailIcon.image = nil
    }
    
    func loadArticleImage() {
        if let urlStr = detailNewsImageUrl {
            let url = URL(string: urlStr)
            //Image Cache using SDWebImage
            articleDetailIcon.sd_setShowActivityIndicatorView(true)
            articleDetailIcon.sd_setIndicatorStyle(.large)
            articleDetailIcon.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "default_place_holder"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
        }
    }

}
