//
//  File.swift
//  
//
//  Created by Dimas Putro on 05/12/21.
//

public struct GameDomainModel: Identifiable, Codable {

  public let id: Int?
  public let name: String?
  public let released: String?
  public let backgroundImage: String?
  public let rating: Float?
  public var genres: [GenresDomainModel]?
  public var screenshots: [ScreenshotsDomainModel]?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case released
    case backgroundImage = "background_image"
    case rating
    case genres
    case screenshots = "short_screenshots"
  }

  public init(id: Int, name: String, released: String, backgroundImage: String, rating: Float, genres: [GenresDomainModel], screenshots: [ScreenshotsDomainModel]) {
    self.id = id
    self.name = name
    self.released = released
    self.backgroundImage = backgroundImage
    self.rating = rating
    self.genres = genres
    self.screenshots = screenshots
  }
}

public struct GenresDomainModel: Codable {
  public  let id: Int
  public let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}

public struct ScreenshotsDomainModel: Codable {
  public let id: Int
  public let image: String

  enum CodingKeys: String, CodingKey {
    case id
    case image
  }
}
