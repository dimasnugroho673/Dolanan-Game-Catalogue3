//
//  File.swift
//  
//
//  Created by Dimas Putro on 06/12/21.
//

import Core

public struct GameTransformer: GameMapper {
  
  public typealias DetailResponse = GameDetailResponse
  public typealias DetailDomain = GameDetailDomainModel
  
  public typealias Request = Any
  public typealias Response = GameResponse
  public typealias Entity = GameDomainEntity
  public typealias Domain = GameDomainModel
  
  public typealias Requests = Any
  public typealias Responses = [GameResponse]
  public typealias Entities = [GameDomainEntity]
  public typealias Domains = [GameDomainModel]
  
  public init() {}
  
  public func transformGamesResponseToDomains(responses: [GameResponse]) -> [GameDomainModel] {
    return responses.map { result in
      return GameDomainModel(id: result.id ?? 0, name: result.name ?? "", released: result.released ?? "", backgroundImage: result.backgroundImage ?? "", rating: result.rating ?? 0.0, genres: self.mapGenres(data: result.genres ?? []), screenshots: [])
    }
  }
  
  public func transformGameDetailResponseToDomain(gameDetailResponse: GameDetailResponse) -> GameDetailDomainModel {
    return GameDetailDomainModel(id: gameDetailResponse.id ?? 0, name: gameDetailResponse.name ?? "", backgroundImage: gameDetailResponse.backgroundImage ?? "", rating: gameDetailResponse.rating ?? 0.0, descriptionRaw: gameDetailResponse.descriptionRaw ?? "", released: gameDetailResponse.released ?? "", ageRating: AgeRatingDomainModel(name: gameDetailResponse.ageRating?.name ?? ""), parentPlatforms: self.mapPlatforms(data: gameDetailResponse.parentPlatforms ?? []), playtime: gameDetailResponse.playtime ?? 0, website: gameDetailResponse.website ?? "", metacriticURL: gameDetailResponse.metacriticURL ?? "", genres: self.mapGenres(data: gameDetailResponse.genres ?? []))
  }
  
  public func transformGameDomainToEntity(gameDomain: GameDomainModel) -> GameDomainEntity {
    let newGame = GameDomainEntity()
    newGame.id = gameDomain.id ?? 0
    newGame.name = gameDomain.name ?? ""
    newGame.released = gameDomain.released ?? ""
    newGame.backgroundImage = gameDomain.backgroundImage ?? ""
    newGame.rating = gameDomain.rating ?? 0.0
    
    return newGame
  }
  
  public func transformGameEntitiesToDomains(gameEntities: [GameDomainEntity]) -> [GameDomainModel] {
    return gameEntities.map { result in
      return GameDomainModel(id: result.id, name: result.name, released: result.released, backgroundImage: result.backgroundImage, rating: result.rating, genres: [], screenshots: [])
    }
  }
  
  private func mapPlatforms(data: [ParentPlatformsResponse]) -> [ParentPlatformsDomainModel] {
    return data.map { result in
      return ParentPlatformsDomainModel(childPlatform: ChildPlatformDomainModel(name: result.childPlatform.name))
    }
  }
  
  private func mapGenres(
    data: [GenresResponse]
  ) -> [GenresDomainModel] {
    return data.map { result in
      return GenresDomainModel(id: result.id, name: result.name)
    }
  }
}
