//
//  MovieTableViewCell.swift
//  BeinSports
//
//  Created by Akın Aksoy on 29.03.2023.
//

import Foundation

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"

    var viewWidth: CGFloat = UIScreen.main.bounds.width
    var viewHeight: CGFloat = UIScreen.main.bounds.height
    var movies: [MovieListResultModel]?
    var delegate: MoviePlayLogic?

    private lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: viewWidth*0.30, height: viewHeight/4)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .black
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
        return collectionView
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray

        return pageControl
    }()

    lazy var headerView: MovieBannerCollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let collectionView = MovieBannerCollectionView(frame: .zero, collectionViewFlowLayout: UICollectionViewFlowLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.movieBannerDataSource = self
        collectionView.autoScrollTimer = 5.0
        collectionView.isAutoScrollEnabled = true
        collectionView.tintColor = .white
        collectionView.backgroundColor = .clear
        collectionView.flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 400)
        collectionView.register(MovieBanner.self, forCellWithReuseIdentifier: MovieBanner.cellIdentifier)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .black

    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func setDesign(section: Int) {
        if section > 0 {
            contentView.addSubview(moviesCollectionView)

            moviesCollectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else if section == 0 {
            contentView.addSubview(headerView)
            self.addSubview(pageControl)
            headerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            pageControl.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-16)
                make.centerX.equalTo(headerView.snp.centerX)
            }

            pageControl.sizeToFit()
            pageControl.subviews.forEach {
                $0.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func configure(section: Int, movieModel: MovieModel, moviePlayer: MoviePlayLogic) {
        setDesign(section: section)
        self.movies = movieModel.results
        pageControl.numberOfPages = movies?.count ?? 0
        moviesCollectionView.reloadData()
        self.delegate = moviePlayer
    }

}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        guard let movie = movies?[indexPath.row] else {return UICollectionViewCell()}
        cell.configure(movie: movie)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = movies else {return}
        delegate?.playVideo(url: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", titleName: movies[indexPath.row].title)
    }

}

extension MovieTableViewCell: MovieBannerCollectionViewDataSource {
    var numberOfItems: Int {
        return movies?.count ?? 0
    }

    func movieBannerCollectionView(_ movieBannerCollectionView: MovieBannerCollectionView, cellForItemAt index: Int, helperIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerView.dequeueReusableCell(withReuseIdentifier: MovieBanner.cellIdentifier, for: helperIndexPath) as! MovieBanner
        guard let posterPath = movies?[index].posterPath, let movieId = self.movies?[index].id else {return UICollectionViewCell()}
        let url = NetworkConstants.imageBaseUrl + posterPath
        cell.fetchImage(imageId: movieId, imageURL: url)
        return cell
    }
    func movieBannerCollectionView(_ movieBannerCollectionView: MovieBannerCollectionView, didDisplayItemAt index: Int) {
        pageControl.currentPage = index
    }
    func movieBannerCollectionView(_ movieBannerCollectionView: MovieBannerCollectionView, didSelectItemAt index: Int) {
        guard let movies = movies else {return}
        delegate?.playVideo(url: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", titleName: movies[index].title)
    }

}
