//
//  MovieListRouter.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation

protocol MovieListRoutingLogic {
    func routeToWatchVideoScene(url: String, titleName: String)
}

final class MovieListRouter: MovieListRoutingLogic {

    var viewController: MovieListViewController?

    func routeToWatchVideoScene(url: String, titleName: String) {
        let vc = VideoViewController()
        vc.configure(mediaURL: url, titleVideo: titleName)

        viewController?.present(vc, animated: true, completion: nil)
    }
}
