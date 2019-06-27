//
//  CategoryCollectionViewCell.swift
//  Inforu
//
//  Created by Rahul Dhiman on 28/06/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(category : String, isSelectedCategory : Bool) {
        self.categoryLabel.text = category
        
        if isSelectedCategory {
            self.categoryLabel.textColor = .black
            self.categoryLabel.font = UIFont.poppinsFontMedium(size: 21.0)
        } else {
            self.categoryLabel.textColor = .lightGray
            self.categoryLabel.font = UIFont.poppinsFontMedium(size: 17.0)
        }
        
    }
    

}
