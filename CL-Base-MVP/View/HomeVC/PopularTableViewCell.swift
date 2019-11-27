//
//  PopularTableViewCell.swift
//  Inforu
//
//  Created by Rahul Dhiman on 27/11/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class PopularTableViewCell: UITableViewCell {

    @IBOutlet weak var factText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(factText : String) {
        self.factText.text = factText
    }
    
}
