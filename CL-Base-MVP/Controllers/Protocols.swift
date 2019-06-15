//
//  CommonProtocols.swift
//  CL-Base-MVP
//
//  Created by shubam garg on 29/03/18.
//  Copyright © 2018 Deepak. All rights reserved.
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

