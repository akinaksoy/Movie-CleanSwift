//
//  MovieListPresenter.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation

protocol MovieListPresentationLogic {
    func presentMovieTable(genreList: Genres)
    func presentMovies(movie: MovieModel)
    func presentError(error: String)
}

final class MovieListPresenter: MovieListPresentationLogic {

    var viewController: MovieListDisplayLogic?

    func presentMovies(movie: MovieModel) {
        viewController?.displayMovies(movie: movie)
    }

    func presentMovieTable(genreList: Genres) {
        viewController?.displayMovieTable(genre: genreList)
    }

    func presentError(error: String) {
        viewController?.displayError(errorMessage: error)
    }
}
