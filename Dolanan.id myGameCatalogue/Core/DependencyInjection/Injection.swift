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
import User

final class Injection: NSObject {

  var realm = try! Realm()

  func provideHome<U: UseCase>() -> U where U.Request == String, U.Response == [GameDomainModel] {
    let locale = GetGamesLocaleDataSource(realm: realm)
    let remote = GetGamesRemoteDataSource(endpoint: "\(Constants.api)games", apiKey: Constants.apiKey)

    let mapper = GameTransformer()

    let repository = GetGamesRepository(
        localeDataSource: locale,
        remoteDataSource: remote,
        mapper: mapper)

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

  func provideUser<U: UseCase>() -> U where U.Request == Any, U.Response == UserDomainModel {
    let locale = GetUserLocaleDataSource(realm: realm)
    let mapper = UserTransformer()

    let repository = GetUserRepository(
      localDataSource: locale,
        mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }

  func provideUpdateUser<U: UseCase>() -> U where U.Request == UserDomainModel, U.Response == UserDomainModel {
    let locale = GetUserLocaleDataSource(realm: realm)
    let mapper = UserTransformer()

    let repository = UpdateUserRepository(
      localDataSource: locale,
        mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }
}
