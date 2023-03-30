//
//  UIImageView+EXT.swift
//  BeinSports
//
//  Created by Akın Aksoy on 29.03.2023.
//

import UIKit

extension UIImageView {

    static var setImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .clear
        return imageView
    }

}
