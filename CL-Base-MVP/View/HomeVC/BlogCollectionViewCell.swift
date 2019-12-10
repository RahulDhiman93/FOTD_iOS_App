//
//  BlogCollectionViewCell.swift
//  Inforu
//
//  Created by Rahul Dhiman on 10/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit
import Kingfisher

class BlogCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var factText: UILabel!
   
    @IBOutlet weak var blogPublisherName: UILabel!
    @IBOutlet weak var blogPublisherImage: UIImageView!
    @IBOutlet weak var imageContView: UIView!
    
    var model : BlogModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    func setupCell() {
        guard let publisherName  = model.addedBy else { return }
        guard let publisherImage = model.userImage else { return }
        guard let fact = model.fact else { return }
        
        self.blogPublisherName.text = publisherName
        self.blogPublisherImage.kf.setImage(with: URL(string: publisherImage), placeholder: UIImage(named: ""))
        self.factText.text = fact
    }
}
