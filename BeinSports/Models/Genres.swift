//
//  Genres.swift
//  BeinSports
//
//  Created by Akın Aksoy on 28.03.2023.
//

import Foundation

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
