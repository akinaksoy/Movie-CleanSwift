//
//  NetworkConstants.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation

struct NetworkConstants {
    
    
    static func generateURLWithFilters(urlType : MovieURLType,
                                language : Bool,sorted:Bool,
                                includeAdult: Bool,
                                includeVideo : Bool,
                                pageNumber : Bool,
                                genreId : Int?) -> String {
        
        var url = NetworkConstants.baseUrl + urlType.rawValue + NetworkConstants.apiKey
        
        if language { url += NetworkConstants.languageFilter}
        if sorted { url += NetworkConstants.sortedBy}
        if includeAdult { url += NetworkConstants.includeAdult}
        if includeVideo { url += NetworkConstants.includeVideo}
        if pageNumber { url += NetworkConstants.pageNumber}
        if let genreId = genreId {
            url += NetworkConstants.withGenres(genreId: genreId)
        }
        return url
    }
    
    
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w185"
    static let apiKey = "api_key=3bb3e67969473d0cb4a48a0dd61af747"
    static let languageFilter = "&language=en-US"
    static let sortedBy = "&sort_by=popularity.desc"
    static let includeAdult = "&include_adult=false"
    static let includeVideo = "&include_video=false"
    static let pageNumber = "&page=1"
    static func withGenres(genreId : Int) -> String {
        return "&with_genres=\(genreId)"
    }
    
    enum MovieURLType : String{
        case genre = "/genre/movie/list?"
        case discover = "discover/movie?"
    }
    enum HTTPMethods : String{
        case GET = "GET"
    }
}

struct RequestError {
    
    enum ErrorTypes : String {
        case NetworkError = "Network Error. Please Try Again"
        case SomethingWentWrong = "Something went wrong. Please Try Again."
    }
    
}
