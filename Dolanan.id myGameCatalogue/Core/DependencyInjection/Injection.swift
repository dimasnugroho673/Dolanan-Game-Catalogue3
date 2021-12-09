//
//  Injection.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import RealmSwift
import Core
import Game
import UIKit

final class Injection: NSObject {

//  var realm: Realm!
  var realm = try! Realm()

  // 1
  func provideHome<U: UseCase>() -> U where U.Request == String, U.Response == [GameDomainModel] {
    let locale = GetGamesLocaleDataSource(realm: realm)
    let remote = GetGamesRemoteDataSource(endpoint: "\(Constants.api)games", apiKey: Constants.apiKey)

    let mapper = GameTransformer()

    let repository = GetGamesRepository(
        localeDataSource: locale,
        remoteDataSource: remote,
        mapper: mapper)

    print(self.realm.configuration.fileURL!)

    return Interactor(repository: repository) as! U
  }

  func provideDetailGame<U: UseCase>() -> U where U.Request == Int, U.Response == GameDetailDomainModel {
    let locale = GetGamesLocaleDataSource(realm: realm)
    let remote = GetGameRemoteDataSource(endpoint: "\(Constants.api)games", apiKey: Constants.apiKey)

    let mapper = GameTransformer()

    let repository = GetGameRepository(
      localDataSource: locale,
      remoteDataSource: remote,
        mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }

  func provideUpdateFavoriteGame<U: UseCase>() -> U where U.Request == GameDomainModel, U.Response == Bool {
    let locale = GetGamesLocaleDataSource(realm: realm)
    let mapper = GameTransformer()

    let repository = UpdateFavoriteGameRepository(
      localDataSource: locale,
        mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }

  func provideSearchGame<U: UseCase>() -> U where U.Request == String, U.Response == [GameDomainModel] {
    let locale = GetGamesLocaleDataSource(realm: realm)
    let remote = GetGamesRemoteDataSource(endpoint: "\(Constants.api)games", apiKey: Constants.apiKey)

    let mapper = GameTransformer()

    let repository = GetGamesRepository(
        localeDataSource: locale,
        remoteDataSource: remote,
        mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideFavoriteGame<U: UseCase>() -> U where U.Request == Any, U.Response == [GameDomainModel] {
    let locale = GetGamesLocaleDataSource(realm: realm)

    let mapper = GameTransformer()

    let repository = GetFavoriteGameRepository(
      localDataSource: locale,
        mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideGameRepository() -> GameRepositoryProtocol {

    // realm injection
    let realm = try? Realm()

    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    let local: LocalDataSource = LocalDataSource.sharedInstance(realm)

    return GameRepository.sharedInstance(remote, local)
  }

  func provideUserRepository() -> UserRepositoryProtocol {

    // realm injection
    let realm = try? Realm()

    let local: LocalDataSource = LocalDataSource.sharedInstance(realm)

    return UserRepository.sharedInstance(local)
  }

//  func provideHome() -> HomeUseCase {
//    let repository = provideGameRepository()
//
//    return HomeInteractor(repository: repository)
//  }

//  func provideDetailGame(game: GameModel) -> DetailGameUseCase {
//    let repository = provideGameRepository()
//
//    return DetailGameInteractor(repository: repository, game: game)
//  }

//  func provideSearchGame() -> SearchGameUseCase {
//    let repository = provideGameRepository()
//
//    return SearchGameInteractor(repository: repository)
//  }

//  func provideFavoriteGame() -> FavoriteGameUseCase {
//    let repository = provideGameRepository()
//
//    return FavoriteGameInteractor(repository: repository)
//  }

  func provideOnboarding() -> UserUseCase {
    let repository = provideUserRepository()

    return UserInteractor(repository: repository)
  }

  func provideUser() -> UserUseCase {
    let repository = provideUserRepository()

    return UserInteractor(repository: repository)
  }

}
