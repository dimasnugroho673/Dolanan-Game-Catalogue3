//
//  File.swift
//  
//
//  Created by Dimas Putro on 05/12/21.
//

import Foundation

public struct GamesReponse: Decodable {
  public var games: [GameResponse]

  enum CodingKeys: String, CodingKey {
    case games = "results"
  }
}

public struct GameResponse: Decodable {
  public let id: Int?
  public let name: String?
  public let released: String?
  public let backgroundImage: String?
  public let rating: Float?
  public var genres: [GenresResponse]?
  public var screenshots: [ScreenshotsResponse]?

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

public struct GenresResponse: Decodable {
  public let id: Int
  public let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}

public struct ScreenshotsResponse: Decodable {
  public let id: Int
  public let image: String

  enum CodingKeys: String, CodingKey {
    case id
    case image
  }
}
