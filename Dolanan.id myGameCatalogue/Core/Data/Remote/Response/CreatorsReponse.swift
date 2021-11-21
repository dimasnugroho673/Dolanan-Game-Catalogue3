//
//  CreatorsReponse.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation

struct CreatorsReponse: Codable {
  var creators: [Creator]

  enum CodingKeys: String, CodingKey {
    case creators = "results"
  }
}

struct CreatorReponse: Codable {
  let id: Int?
  let name: String?
  let image: String?
  let imageBackground: String?
  let gamesCount: Int?
  var positions: [PositionsResponse]?
  var games: [CreatorGamesReponse]?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case image
    case imageBackground = "image_background"
    case gamesCount = "games_count"
    case positions
    case games
  }
}

struct PositionsResponse: Codable {

  let id: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}

struct CreatorGamesReponse: Codable {
  let id: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}
