//
//  InputTextFieldCell.swift
//  CL-Base-MVP
//
//  Created by Deepak Sharma on 11/28/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

protocol InputTextFieldCellDelegate: class {
    func shouldChange(text: String, string: String, cell: UITableViewCell) -> Bool
    func buttonTapped(call: UITableViewCell)
}

struct DataTextModel: CellDataModelProtocol {
    var identifier: String
    var title: String
    var showError: Bool = false
    var error: TextFieldError?
    var showInfoBtn: Bool = true
    var infoImage: UIImage?
    var keyBoardType: UIKeyboardType = .default
    var secureEntry = false
    var data: String?
    var highLighterColor: UIColor = .normalLineColor
    
    init(identifier: String, title: String, data: String? = nil) {
        self.identifier = identifier
        self.title = title
        self.data = data
    }
}


class InputTextFieldCell: UITableViewCell {

    @IBOutlet var txtInput: UITextField!
    weak var delegate: InputTextFieldCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func cellIdentifier() -> String {
        return String(describing: InputTextFieldCell.self)
    }
    
    func setupView(viewModel: DataTextModel) {
        txtInput.placeholder = viewModel.title
        txtInput.placeHolderColor = .placeHolderColor
        txtInput.isSecureTextEntry = viewModel.secureEntry
        txtInput.keyboardType = viewModel.keyBoardType
        txtInput.text = viewModel.data ?? ""
        
    }
    
}
extension InputTextFieldCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       // highlighterView.backgroundColor = .highlightLineColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       // highlighterView.backgroundColor = .normalLineColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let txtString = textField.text else {
            return false
        }
        let finalString = (txtString as NSString).replacingCharacters(in: range, with: string)
        return self.delegate?.shouldChange(text: finalString, string: string, cell: self) ?? false
    }
}
