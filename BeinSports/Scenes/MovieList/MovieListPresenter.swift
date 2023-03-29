//
//  MovieListPresenter.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation

protocol MovieListPresentationLogic {
    func presentMovieTable(genreList : Genres)
    func presentMovies(movie : MovieModel)
}

final class MovieListPresenter : MovieListPresentationLogic {
    
    func presentMovies(movie: MovieModel) {
        viewController?.displayMovies(movie: movie)
    }
    
    func presentMovieTable(genreList : Genres) {
        viewController?.displayMovieTable(genre: genreList)
    }
    
    
    
    var viewController : MovieListDisplayLogic?
    
    
}
