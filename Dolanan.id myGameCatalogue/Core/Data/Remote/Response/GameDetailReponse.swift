//
//  GameDetailReponse.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation

struct GameDetailResponse: Decodable {
  let id: Int?
  let name: String?
  let backgroundImage: String?
  let rating: Float?
  let descriptionRaw: String?
  let released: String?
  var ageRating: AgeRatingResponse?
  var parentPlatforms: [ParentPlatformsResponse]?
  let playtime: Int?
  let website: String?
  let metacriticURL: String?
  var genres: [GenresResponse]?

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

struct AgeRatingResponse: Decodable {
  let name: String

  enum CodingKeys: String, CodingKey {
    case name
  }
}

struct ParentPlatformsResponse: Decodable {
  let childPlatform: ChildPlatformResponse

  enum CodingKeys: String, CodingKey {
    case childPlatform = "platform"
  }
}

struct ChildPlatformResponse: Decodable {
  let name: String

  enum CodingKeys: String, CodingKey {
    case name
  }
}
