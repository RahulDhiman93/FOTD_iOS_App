//
//  PopularTableViewCell.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit
import SkeletonView

class PopularTableViewCell: UITableViewCell {

    @IBOutlet weak var factText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.isSkeletonable = true
        self.factText.isSkeletonable = true
        // Initialization code
    }

    func configCell(factText : String) {
        self.factText.text = factText
    }
    
}
