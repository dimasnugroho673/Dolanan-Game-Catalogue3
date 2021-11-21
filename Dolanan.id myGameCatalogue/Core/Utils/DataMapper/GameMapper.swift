//
//  PopularGameMapper.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation

final class GameMapper {

  static func mapPopularGameResponsesToDomains(
    input popularReponses: [GameResponse]
  ) -> [GameModel] {
    return popularReponses.map { result in
      return GameModel(id: result.id ?? 0, name: result.name ?? "", released: result.released ?? "", backgroundImage: result.backgroundImage ?? "", rating: result.rating ?? 0.0, genres: nil, screenshots: nil)
    }
  }

  static func mapGameDetailResponseToDomains(
    input gameDetailResponse: GameDetailResponse
  ) -> GameDetailModel {
    return GameDetailModel(id: gameDetailResponse.id ?? 0, name: gameDetailResponse.name ?? "", backgroundImage: gameDetailResponse.backgroundImage ?? "", rating: gameDetailResponse.rating ?? 0.0, descriptionRaw: gameDetailResponse.descriptionRaw ?? "", released: gameDetailResponse.released ?? "", ageRating: AgeRating(name: gameDetailResponse.ageRating?.name ?? ""), parentPlatforms: nil, playtime: gameDetailResponse.playtime ?? 0, website: gameDetailResponse.website ?? "", metacriticURL: gameDetailResponse.metacriticURL ?? "", genres: nil)
  }

  static func mapGameModelToEntities(
    input gameModel: GameModel
  ) -> GameEntity {
    let newGame = GameEntity()
    newGame.id = gameModel.id ?? 0
    newGame.name = gameModel.name ?? ""
    newGame.released = gameModel.released ?? ""
    newGame.backgroundImage = gameModel.backgroundImage ?? ""
    newGame.rating = gameModel.rating ?? 0.0

    return newGame
  }

  static func mapGameEntitiesToDomains(
    input gameEntities: [GameEntity]
  ) -> [GameModel] {
    return gameEntities.map { result in
      return GameModel(id: result.id, name: result.name, released: result.released, backgroundImage: result.backgroundImage, rating: result.rating, genres: nil, screenshots: nil)
    }
  }

}
