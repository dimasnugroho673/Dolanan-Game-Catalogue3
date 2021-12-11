//
//  File.swift
//  
//
//  Created by Dimas Putro on 07/12/21.
//

import Core

public struct GameDetailTransformer: GameDetailMapper {
  public typealias Request = Int
  public typealias Response = GameDetailResponse
  public typealias Domain = GameDetailDomainModel
  public typealias Entity = GameDomainEntity
  
  public init() {}
  
  public func transformResponseToDomain(request: Int?, response: GameDetailResponse) -> GameDetailDomainModel {
    return GameDetailDomainModel(
      id: request ?? 0,
      name: response.name ?? "",
      backgroundImage: response.backgroundImage ?? "",
      rating: response.rating ?? 0.0,
      descriptionRaw: response.descriptionRaw ?? "",
      released: response.released ?? "",
      ageRating: AgeRatingDomainModel(name: response.ageRating?.name ?? ""),
      parentPlatforms: self.mapPlatforms(data: response.parentPlatforms ?? []),
      playtime: response.playtime ?? 0,
      website: response.website ?? "",
      metacriticURL: response.metacriticURL ?? "",
      genres: self.mapGenres(data: response.genres ?? [])
    )
  }
  
  public func transformDomainToEntity(request: GameDetailDomainModel) -> GameDomainEntity {
    let newGame = GameDomainEntity()
    newGame.id = request.id ?? 0
    newGame.name = request.name ?? ""
    newGame.released = request.released ?? ""
    newGame.backgroundImage = request.backgroundImage ?? ""
    newGame.rating = request.rating ?? 0.0
    
    return newGame
  }
  
  private func mapPlatforms(data: [ParentPlatformsResponse]) -> [ParentPlatformsDomainModel] {
    return data.map { result in
      return ParentPlatformsDomainModel(childPlatform: ChildPlatformDomainModel(name: result.childPlatform.name))
    }
  }
  
  private func mapGenres(data: [GenresResponse]) -> [GenresDomainModel] {
    return data.map { result in
      return GenresDomainModel(id: result.id, name: result.name)
    }
  }
}
