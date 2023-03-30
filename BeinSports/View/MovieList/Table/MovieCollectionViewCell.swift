//
//  MovieCollectionViewCell.swift
//  BeinSports
//
//  Created by Akın Aksoy on 29.03.2023.

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "MovieCollectionViewCell"
    // MARK: - UI Outlet
    var movieImage = UIImageView.setImageView
    let movieNameLabel = UILabel(text: "", fontSize: 12, fontColor: .black, fontTypes: .deffault)
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setPageDesign()
    }

    required init(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    // MARK: - UI Configuration
    func setDesignCell() {
        self.backgroundColor = .gray
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }

    func setPageDesign() {
        setDesignCell()
        self.addSubview(movieImage)
        self.addSubview(movieNameLabel)

        movieImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview()
        }

        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp_bottomMargin).offset(8)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    func configure(movie: MovieListResultModel) {
        movieNameLabel.text = movie.title
        let url = NetworkConstants.imageBaseUrl + movie.posterPath
        fetchImage(imageId: movie.id, imageURL: url)
    }
    func fetchImage(imageId: Int, imageURL: String) {
        ImageManager.shared.fetchImage(imageId: String(imageId), imageUrl: imageURL) { image in
            if let image = image {
                self.movieImage.image = image
            }
        }
    }

}
