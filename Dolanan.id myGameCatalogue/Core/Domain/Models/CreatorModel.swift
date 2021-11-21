//
//  CreatorModel.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation

struct CreatorModel: Codable {
  var creators: [Creator]

  enum CodingKeys: String, CodingKey {
    case creators = "results"
  }
}

struct Creator: Codable {
  let id: Int?
  let name: String?
  let image: String?
  let imageBackground: String?
  let gamesCount: Int?
  var positions: [Positions]?
  var games: [CreatorGames]?

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

struct Positions: Codable {

  let id: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}

struct CreatorGames: Codable {
  let id: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}
