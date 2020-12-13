//
//  ArticleTVC.swift
//  NyTimesNewsApp
//
//  Created by Admin on 12/12/20.
//

import UIKit
import SDWebImage

class ArticleTVC: UITableViewCell {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var byLineLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var dateIcon:UIImageView!
    @IBOutlet weak var articleIcon:UIImageView!

    var articleCellVM : ArticleCellViewModel? {
        didSet {
            guard let articleCellVM = articleCellVM else {
                return
            }
            titleLabel?.text = articleCellVM.title
            byLineLabel?.text = articleCellVM.byLineString
            dateLabel?.text = Utils.getStringFromDate(date: articleCellVM.publishedDate)
            
            if let urlStr = articleCellVM.imageUrl {
                let url = URL(string: urlStr)
                //Image Cache using SDWebImage
                articleIcon.sd_setShowActivityIndicatorView(true)
                articleIcon.sd_setIndicatorStyle(.large)
                articleIcon.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "default_place_holder"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCellUI() {
        self.dateIcon?.image = #imageLiteral(resourceName: "date_icon")
        self.titleLabel?.textColor = kPrimaryTextColor
        self.byLineLabel?.textColor = kSecondryTextColor
        self.dateLabel?.textColor = kSecondryTextColor
    }
}
