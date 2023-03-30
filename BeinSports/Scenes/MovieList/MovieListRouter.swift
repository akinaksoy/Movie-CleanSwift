//
//  MovieListRouter.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation

protocol MovieListRoutingLogic {
    func routeToWatchVideoScene(url: String)
}

final class MovieListRouter: MovieListRoutingLogic {

    var viewController: MovieListViewController?

    func routeToWatchVideoScene(url: String) {
        let vc = VideoViewController()
        vc.configure(mediaURL: url)

        viewController?.present(vc, animated: true, completion: nil)
    }
}
