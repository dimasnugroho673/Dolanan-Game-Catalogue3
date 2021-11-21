//
//  PopularGame.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation

struct GameModel: Identifiable, Codable {
  let id: Int?
  let name: String?
  let released: String?
  let backgroundImage: String?
  let rating: Float?
  var genres: [Genres]?
  var screenshots: [Screenshots]?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case released
    case backgroundImage = "background_image"
    case rating
    case genres
    case screenshots = "short_screenshots"
  }
}

struct Genres: Codable {
  let id: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}

struct Screenshots: Codable {
  let id: Int
  let image: String

  enum CodingKeys: String, CodingKey {
    case id
    case image
  }
}
