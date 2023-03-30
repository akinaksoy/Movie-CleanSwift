//
//  MovieListWorker.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation
import Alamofire

final class MovieListWorker {

    func fetchGenreTypes(completion: @escaping (Genres?, RequestError.ErrorTypes?) -> Void) {
        guard let url = URL(string: NetworkConstants.generateURLWithFilters(urlType: .genre, language: true, sorted: false, includeAdult: false, includeVideo: false, pageNumber: false, genreId: nil)) else {return}

        APIService.request(url, method: .GET) {responseData in
            if let response = responseData.data {
                do {
                    let genre = try JSONDecoder().decode(Genres.self, from: response)
                    completion(genre, nil)
                } catch {
                    completion(nil, .NetworkError)
                }
            }
        }
    }

    func fetchMovies(genreId: Int, completion: @escaping (MovieModel?, RequestError.ErrorTypes?) -> Void) {
        DispatchQueue.main.async {

            guard let url = URL(string: NetworkConstants.generateURLWithFilters(urlType: .discover, language: false, sorted: true, includeAdult: true, includeVideo: true, pageNumber: true, genreId: genreId)) else {return}
            APIService.request(url, method: .GET) { responseData in
                print(responseData.data!)
                if let response = responseData.data {
                    if let movie = try? JSONDecoder().decode(MovieModel.self, from: response) {
                        completion(movie, nil)
                    }
                } else {
                    completion(nil, .NetworkError)
                }
            }
        }
    }

}
