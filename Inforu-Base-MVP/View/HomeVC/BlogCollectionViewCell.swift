//
//  BlogCollectionViewCell.swift
//  Inforu
//
//  Created by Rahul Dhiman on 10/12/19.
//  Copyright © 2022 Rahul. All rights reserved.
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            UIView.animate(withDuration: 0.01, animations: {
                self.imageContView.layer.cornerRadius = self.imageContView.layer.frame.height/2
                self.layoutIfNeeded()
            })
        })
        
        // Initialization code
       
    }

    func setupCell() {
        guard let publisherName  = model.addedBy else { return }
        guard let publisherImage = model.userImage else { return }
        guard let fact = model.fact else { return }
        
        self.blogPublisherName.text = publisherName
        self.blogPublisherImage.kf.setImage(with: URL(string: publisherImage), placeholder: UIImage(named: "placeholder"))
        self.factText.text = fact
    }
}
