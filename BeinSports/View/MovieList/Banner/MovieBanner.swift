//
//  MovieBanner.swift
//  BeinSports
//
//  Created by Akın Aksoy on 29.03.2023.
//

import Foundation
import UIKit
class MovieBanner: UICollectionViewCell {
    static let cellIdentifier = "MovieBanner"

    private var cardHeight = Int(UIScreen.main.bounds.height)/3

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.height.equalTo(self.cardHeight)
            make.center.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layoutIfNeeded()
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = 32
            self.imageView.clipsToBounds = true
        }
    }

    func fetchImage(imageId: Int, imageURL: String) {
        ImageManager.shared.fetchImage(imageId: String(imageId), imageUrl: imageURL) { image in
            if let image = image {
                self.imageView.image = image
            }
        }
    }
}
