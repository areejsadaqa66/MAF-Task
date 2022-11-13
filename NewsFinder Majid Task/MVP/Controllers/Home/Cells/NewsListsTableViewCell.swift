//
//  NewsListsTableViewCell.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import UIKit

class NewsListsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var authurLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        selectionStyle = .none
    }
    
    internal func fillCell(sectionType:ProvidersType?, _ newsAPILists:Article?, _ newsDataLists:Result?) {
        switch sectionType {
        case .NewsAPI:
            newsImage.sd_setImage(with: URL(string: newsAPILists?.urlToImage ?? ""), placeholderImage: UIImage(named: "majid"))
            newsTitleLabel.text = newsAPILists?.title ?? ""
            authurLabel.text = newsAPILists?.author ?? ""
            dateLabel.text = convertDate(newsAPILists?.publishedAt ?? "", dateFormat: "dd/MM/yyyy")
            
        case .NewsData:
            newsImage.sd_setImage(with: URL(string: newsDataLists?.imageURL ?? ""), placeholderImage: UIImage(named: "majid"))
            newsTitleLabel.text = newsDataLists?.title ?? ""
            authurLabel.text =  newsDataLists?.creator?.reduce("0") { $0 + $1 } ?? ""
            dateLabel.text = convertDate(newsDataLists?.pubDate ?? "", dateFormat: "dd/MM/yyyy")
           
        case .none:
            break
        }
    }
}
