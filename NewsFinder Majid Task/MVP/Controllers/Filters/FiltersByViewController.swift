//
//  FiltersByViewController.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 12/11/2022.
//

import UIKit

class FiltersByViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var filtersByLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables

    //MARK: - Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - Helpers

    //MARK: - Actions
}

extension FiltersByViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView DataSource and Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilterType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        cell.textLabel?.text = FilterType(rawValue: indexPath.row)?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc =  UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FiltersDetailsViewController") as? FiltersDetailsViewController {
            vc.presenter = FiltersDetailsPresenter(vc)
            vc.presenter?.filterType = FilterType(rawValue: indexPath.row)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
