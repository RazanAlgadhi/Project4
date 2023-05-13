//
//  ImageViewCollectionCell.swift
//  VirtualTouristRaz
//
//  Created by pc on 10/05/2023.
//

import UIKit

class ImageViewCollectionCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    func configureUI(image: UIImage?) {
        imageView.image = image
    }
}
