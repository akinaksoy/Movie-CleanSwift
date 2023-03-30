//
//  ViewController.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import UIKit
import SnapKit
import AVKit
protocol MovieListDisplayLogic {
    func displayMovieTable(genre: Genres)
    func displayMovies(movie: MovieModel)
}

protocol MoviePlayLogic {
    func playVideo(url: String)
}

class MovieListViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        return tableView
    }()

    private var interactor: MovieListInteractor?
    private var router: MovieListRouter?

    private var genreCategories: Genres?
    private var movies: [MovieModel] = [MovieModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure(title: "Film")
        interactor?.getGenreTypes()
        tableView.reloadData()
    }

    func setup() {
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self

        self.interactor = interactor
        self.router = router

    }

    override func configure(title: String) {
        super.configure(title: title)
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return genreCategories?.genres.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        if movies.count > 1 && movies.count > indexPath.section {
            cell.configure(section: indexPath.section, movieModel: movies[indexPath.section], moviePlayer: self)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.3
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        let headerImage = UIImage(systemName: "ellipsis.circle.fill")
        let headerImageView = UIImageView(image: headerImage)
        headerImageView.tintColor = .purple
        header.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if movies.count != 0 && movies.count > section && section != 0 {
            return genreCategories?.genres[section].name
        } else {
            return ""
        }
    }
}

extension MovieListViewController: MovieListDisplayLogic {
    func displayMovies(movie: MovieModel) {
        self.movies.append(movie)
        tableView.reloadData()
    }

    func displayMovieTable(genre: Genres) {
        genreCategories = genre
        interactor?.getMovies(request: MovieListModels.GenresReq.request(genres: self.genreCategories))
    }
}

extension MovieListViewController: MoviePlayLogic {
    func playVideo(url: String) {
        router?.routeToWatchVideoScene(url: url)
    }

}
