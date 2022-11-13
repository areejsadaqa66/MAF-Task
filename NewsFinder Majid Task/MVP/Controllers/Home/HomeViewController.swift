//
//  HomeViewController.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 11/11/2022.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var filtersButton: UIButton!
    
    //MARK: - Variables
    var presenter: HomePresenter?

    //MARK: - Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Helpers
    func setupView(){
        title = "Breaking News"
        tableView.register(UINib(nibName: "NewsListsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListsTableViewCell")
        presenter?.getHomeRequests()
    }
    
    //MARK: - Actions
    @IBAction func filtersButtonAction(_ sender: UIButton) {
        if let vc =  UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FiltersByViewController") as? FiltersByViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func resetButtonAction(_ sender: UIButton) {
        presenter?.resetFilter()
        tableView.reloadData()
    }
}

//MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView DataSource and Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProvidersType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = ProvidersType(rawValue: section) else { return 0 }
        switch sectionType {
        case .NewsAPI:
            return presenter?.newsAPIFilteredArticles?.count ?? 0
        case .NewsData:
            return presenter?.newsDataFilteredResults?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = ProvidersType(rawValue: indexPath.section) else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListsTableViewCell", for: indexPath) as? NewsListsTableViewCell else { return UITableViewCell() }
        switch sectionType {
        case .NewsAPI:
            if let newsAPIArticles = presenter?.newsAPIFilteredArticles?[indexPath.row] {
                cell.fillCell(sectionType: .NewsAPI, newsAPIArticles, nil)
            }
        case .NewsData:
            if let newsDataResults = presenter?.newsDataFilteredResults?[indexPath.row] {
                cell.fillCell(sectionType: .NewsData, nil, newsDataResults)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc =  UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeDetailsViewController") as? HomeDetailsViewController {
            guard let sectionType = ProvidersType(rawValue: indexPath.section) else { return }
            switch sectionType {
            case .NewsAPI:
                vc.providersType = .NewsAPI
                vc.newsAPIArticles = presenter?.newsAPIFilteredArticles?[indexPath.row]
            case .NewsData:
                vc.providersType = .NewsData
                vc.newsDataResults = presenter?.newsDataFilteredResults?[indexPath.row]
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - View Presenter
extension HomeViewController: HomeViewPresenter {
    
    func filterHandler(notification: NSNotification) {
        guard let filterObject = notification.object as? SelectedFilterModel else {return}
        switch filterObject.filterType {
        case .Country:
            presenter?.newsDataFilteredResults = presenter?.newsDataResults?.filter({$0.country?.first?.lowercased() == filterObject.filterCountry?.name.lowercased()})
            presenter?.newsAPIFilteredArticles = []
        case .Categories:
            presenter?.newsDataFilteredResults = presenter?.newsDataResults?.filter({$0.category?.first?.lowercased() == filterObject.filterCategory?.name.lowercased()})
            presenter?.newsAPIFilteredArticles = []
        case .none:
            break
        }
        self.tableView.reloadData()
    }
    
    func newsAPIFailed(_ error: String) {
        let alert = UIAlertController.init(title: "Warning!", message: "News API Provider Error", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func newsDataFailed(_ error: String) {
        let alert = UIAlertController.init(title: "Warning!", message: "News Data Provider Error", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showData(_ newsAPIResponse: NewsAPIResponse, _ newsDataResponse: NewsDataResponse) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
