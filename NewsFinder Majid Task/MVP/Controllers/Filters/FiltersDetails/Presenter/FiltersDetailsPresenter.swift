//
//  FiltersDetailsPresenter.swift
//  NewsFinder Majid Task
//
//  Created by areej sadaqa on 13/11/2022.
//

import Foundation

protocol FiltersDetailsViewPresenter:NSObjectProtocol{
    func didSelectedCell(index:Int)
}

final class FiltersDetailsPresenter {
    
    var filterKeyword :String?
    var filterType :FilterType?
    
    fileprivate weak var viewPresenter:FiltersDetailsViewPresenter?
    init(_ view:FiltersDetailsViewPresenter) {
        viewPresenter = view
    }
    
    func didSelected(index:Int) {
        self.viewPresenter?.didSelectedCell(index: index)
    }
}
