//
//  HomeDetailsViewController.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 12/11/2022.
//

import UIKit

class HomeDetailsViewController: UIViewController {

    /**
     This class for ....
     */
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var authurLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Variables
    var newsAPIArticles:Article?
    var newsDataResults:Result? 
    var providersType:ProvidersType?
    
    //MARK: - Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      setupView()
    }
    //MARK: - Helpers
    func setupView(){
        title = "News Details"
        switch providersType {
        case .NewsAPI:
            titleLabel.text = newsAPIArticles?.title
            newsImage.sd_setImage(with: URL(string: newsAPIArticles?.urlToImage ?? ""), placeholderImage: UIImage(named: "majid"))
            dateLabel.text = convertDate(newsAPIArticles?.publishedAt ?? "", dateFormat: "dd/MM/yyyy")
            authurLabel.text = newsAPIArticles?.author
            descriptionLabel.text = newsAPIArticles?.articleDescription
        case .NewsData:
            newsImage.sd_setImage(with: URL(string: newsDataResults?.imageURL ?? ""), placeholderImage: UIImage(named: "majid"))
            titleLabel.text = newsDataResults?.title ?? ""
            authurLabel.text =  newsDataResults?.creator?.reduce("0") { $0 + $1 } ?? ""
            dateLabel.text = convertDate(newsDataResults?.pubDate ?? "", dateFormat: "dd/MM/yyyy")
            descriptionLabel.text = newsDataResults?.resultDescription
        case .none:
            break
        }
    }
    
    
    //MARK: - Actions
 
    
    //MARK: - Functions

}
