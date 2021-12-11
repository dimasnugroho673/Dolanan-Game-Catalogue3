//
//  File.swift
//  
//
//  Created by Dimas Putro on 07/12/21.
//

public struct GameDetailDomainModel: Codable {
  public let id: Int?
  public let name: String?
  public let backgroundImage: String?
  public let rating: Float?
  public let descriptionRaw: String?
  public let released: String?
  public var ageRating: AgeRatingDomainModel?
  public var parentPlatforms: [ParentPlatformsDomainModel]?
  public let playtime: Int?
  public let website: String?
  public let metacriticURL: String?
  public var genres: [GenresDomainModel]?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case backgroundImage = "background_image"
    case rating
    case descriptionRaw = "description_raw"
    case released
    case ageRating = "esrb_rating"
    case parentPlatforms = "parent_platforms"
    case playtime
    case website
    case metacriticURL = "metacritic_url"
    case genres
  }
}

public struct AgeRatingDomainModel: Codable {
  public let name: String

  enum CodingKeys: String, CodingKey {
    case name
  }
}

public struct ParentPlatformsDomainModel: Codable {
  public let childPlatform: ChildPlatformDomainModel

  enum CodingKeys: String, CodingKey {
    case childPlatform = "platform"
  }
}

public struct ChildPlatformDomainModel: Codable {
  public let name: String

  enum CodingKeys: String, CodingKey {
    case name
  }
}
