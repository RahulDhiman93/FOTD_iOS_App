//
//  SignupButtonCell.swift
//  CL-Base-MVP
//
//  Created by Deepak on 29/11/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

protocol SignupButtonCellDelegate: class {
    func buttonTapped(on cell: UITableViewCell)
}

struct SignupButtonCellModel: CellDataModelProtocol {
    var identifier: String
    var title: String
    var borderColor: UIColor = .clear
    var backgroundColor: UIColor = .spBtnPinkColor
    var textColor: UIColor = .white
    init(identifier: String, title: String) {
        self.identifier = identifier
        self.title = title
    }
}

class SignupButtonCell: UITableViewCell {
    
    weak var delegate: SignupButtonCellDelegate?
    @IBOutlet weak var btnSignup: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonTapped(on: self)
    }
    
    func setup(viewModel: SignupButtonCellModel) {
        btnSignup.setTitle(viewModel.title, for: .normal)
        btnSignup.backgroundColor = viewModel.backgroundColor
        btnSignup.setTitleColor(viewModel.textColor, for: .normal)
        btnSignup.layer.borderColor = viewModel.borderColor.cgColor
        btnSignup.layer.borderWidth = 2
    }
    class func cellIdentifier() -> String {
        return String(describing: SignupButtonCell.self)
    }
}
