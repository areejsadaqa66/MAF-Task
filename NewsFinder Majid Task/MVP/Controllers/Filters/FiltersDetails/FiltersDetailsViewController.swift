//
//  FiltersDetailsViewController.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 12/11/2022.
//

import UIKit

class FiltersDetailsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var filtersDetailsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var presenter: FiltersDetailsPresenter?
    
    //MARK: - Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK: - Helpers
    func setupView(){
        filtersDetailsLabel.text = presenter?.filterType == .Country ? "By Country" : "By Categories"
    }
    //MARK: - Actions
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    //MARK: - Functions
    
}

extension FiltersDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView DataSource and Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionType = presenter?.filterType else { return 0 }
        switch sectionType {
        case .Country:
            return Countries.allCases.count
        case .Categories:
            return Categories.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        guard let sectionType = presenter?.filterType else { return UITableViewCell() }
        switch sectionType {
        case .Country:
            cell.textLabel?.text = Countries.init(rawValue: indexPath.row)?.code
            cell.accessoryType = (cell.textLabel?.text == presenter?.filterKeyword) ? .checkmark: .none
        case .Categories:
            cell.textLabel?.text = Categories.init(rawValue: indexPath.row)?.name
            cell.accessoryType = (cell.textLabel?.text == presenter?.filterKeyword) ? .checkmark: .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        self.presenter?.didSelected(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
}

extension FiltersDetailsViewController: FiltersDetailsViewPresenter {
    func didSelectedCell(index: Int) {
        presenter?.filterKeyword = (presenter?.filterType == .Country) ? Countries.init(rawValue: index)?.code  :Categories.init(rawValue: index)?.name
        NotificationCenter.default.post(name:selectedFilter, object: SelectedFilterModel(filterType: presenter?.filterType, filterCountry: Countries.init(rawValue: index), filterCategory: Categories.init(rawValue: index)))
    }
}
