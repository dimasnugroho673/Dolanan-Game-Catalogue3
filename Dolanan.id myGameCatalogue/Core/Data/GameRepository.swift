//
//  GameRepository.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import Combine
import RxSwift

//protocol GameRepositoryProtocol {
//  func getPopularGames() -> AnyPublisher<[PopularGame], Error>
//}
//
//final class GameRepository: NSObject {
//  typealias GameInstance = (RemoteDataSource) -> GameRepository
//
//  fileprivate let remote: RemoteDataSource
//
//  private init(remote: RemoteDataSource) {
//    self.remote = remote
//  }
//
//  static let sharedInstance: GameInstance = { remoteRepo in
//    return GameRepository(remote: remoteRepo)
//  }
//}
//
//extension GameRepository: GameRepositoryProtocol {
//
//  func getPopularGames() -> AnyPublisher<[PopularGame], Error> {
//    return self.remote.getPopularGames()
//      .map { PopularGameMapper.mapPopularGameResponsesToDomains(input: $0) }
//  }
//}

protocol GameRepositoryProtocol {
  func getPopularGames() -> Observable<[GameModel]>
  func getDetailGame(id: Int) -> Observable<GameDetailModel>
  func getGamesByKeyword(keyword: String) -> Observable<[GameModel]>
  func addGameToFavorite(data: GameModel) -> Observable<Bool>
  func getFavoriteGames() -> Observable<[GameModel]>
}

final class GameRepository: NSObject {
  typealias GameInstance = (RemoteDataSource, LocalDataSource) -> GameRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let local: LocalDataSource

  private init(remote: RemoteDataSource, local: LocalDataSource) {
    self.remote = remote
    self.local = local
  }

  static let sharedInstance: GameInstance = { remoteRepository, localRepository in
    return GameRepository(remote: remoteRepository, local: localRepository)
  }
}

extension GameRepository: GameRepositoryProtocol {

  func getPopularGames() -> Observable<[GameModel]> {
    return self.remote.getPopularGames()
      .map { GameMapper.mapPopularGameResponsesToDomains(input: $0) }
  }

  func getDetailGame(id: Int) -> Observable<GameDetailModel> {
    return self.remote.getDetailGame(id: id)
      .map { GameMapper.mapGameDetailResponseToDomains(input: $0) }
  }

  func getGamesByKeyword(keyword: String) -> Observable<[GameModel]> {
    return self.remote.getGamesByKeyword(keyword: keyword)
      .map { GameMapper.mapPopularGameResponsesToDomains(input: $0) }
  }

  func addGameToFavorite(data: GameModel) -> Observable<Bool> {
    return self.local.addGameToFavorite(data: GameMapper.mapGameModelToEntities(input: data))
  }

  func getFavoriteGames() -> Observable<[GameModel]> {
    return self.local.getFavoriteGames()
      .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
  }

}
