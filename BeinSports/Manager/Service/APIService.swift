//
//  APIService.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation
import Alamofire

class APIService {

    class func request(_ url: URL,
                       method: NetworkConstants.HTTPMethods,
                       completion: @escaping (RequestModel) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                let requestModel = RequestModel(data: data, response: httpResponse, error: error)
                completion(requestModel)
            }
        })

        task.resume()
    }
}
