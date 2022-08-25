//
//  MoreRowsTableViewCell.swift
//  Inforu
//
//  Created by Rahul Dhiman on 12/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit

class MoreRowsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tabImage: UIImageView!
    @IBOutlet weak var tabName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(image : String, name : String) {
        self.tabName.text = name
        self.tabImage.image = UIImage(named: image)
    }
}
