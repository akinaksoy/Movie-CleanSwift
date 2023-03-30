//
//  MovieListInteractor.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation

protocol MovieListBusinessLogic {
    func getGenreTypes()
    func getMovies(request: MovieListModels.GenresReq.request)
}

final class MovieListInteractor {

    var presenter: MovieListPresentationLogic?
    lazy var worker = MovieListWorker()
    func getGenreTypes() {
        worker.fetchGenreTypes { response, error in
            if let response = response {
                self.presenter?.presentMovieTable(genreList: response)
            } else if let error = error {
                self.presenter?.presentError(error: error.rawValue)
            }
        }
    }

    func getMovies(request: MovieListModels.GenresReq.request) {
        guard let genres = request.genres else {return}
        for genre in genres.genres.enumerated() {
            worker.fetchMovies(genreId: genre.element.id) { movie, error in
                if let movie = movie {
                    self.presenter?.presentMovies(movie: movie)
                } else if let error = error {
                    self.presenter?.presentError(error: error.rawValue)
                }
            }
        }
    }
}
