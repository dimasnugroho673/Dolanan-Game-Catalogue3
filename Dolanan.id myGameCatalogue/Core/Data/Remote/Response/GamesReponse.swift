//
//  PopularGamesReponse.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation

struct GamesReponse: Decodable {
  var games: [GameResponse]

  enum CodingKeys: String, CodingKey {
    case games = "results"
  }
}

struct GameResponse: Decodable {
  let id: Int?
  let name: String?
  let released: String?
  let backgroundImage: String?
  let rating: Float?
  var genres: [GenresResponse]?
  var screenshots: [ScreenshotsResponse]?

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

struct GenresResponse: Decodable {
  let id: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}

struct ScreenshotsResponse: Decodable {
  let id: Int
  let image: String

  enum CodingKeys: String, CodingKey {
    case id
    case image
  }
}
