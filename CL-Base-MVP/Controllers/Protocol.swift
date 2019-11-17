//
//  Protocol.swift
//  Inforu
//
//  Created by Rahul Dhiman on 17/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterDataSource {
    func viewModel(indexPath: IndexPath) -> CellDataModelProtocol
}

protocol PresenterTableDataSource {
    var numberOfSection: Int { get }
}

protocol CellDataModelProtocol {
    var identifier: String {get set}
}

protocol Router {
     var view: UIViewController? {
        get set
    }
    init(with view: UIViewController)
}

protocol TableViewProtocols: class {
    func reloadTableView()
    func reloadIndexPath(indexpath: IndexPath)
}

