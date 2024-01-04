//
//  CustomCollectionViewCell.swift
//  PhotosCollectionViewAssignment
//
//  Created by Mac on 04/01/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postUrlImageView: UIImageView!
    @IBOutlet weak var postthumbnailUrlImageView: UIImageView!
    @IBOutlet weak var albumIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
