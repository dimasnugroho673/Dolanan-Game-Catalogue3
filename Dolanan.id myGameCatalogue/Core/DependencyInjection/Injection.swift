//
//  Injection.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

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

  func provideHome() -> HomeUseCase {
    let repository = provideGameRepository()

    return HomeInteractor(repository: repository)
  }

  func provideDetailGame(game: GameModel) -> DetailGameUseCase {
    let repository = provideGameRepository()

    return DetailGameInteractor(repository: repository, game: game)
  }

  func provideSearchGame() -> SearchGameUseCase {
    let repository = provideGameRepository()

    return SearchGameInteractor(repository: repository)
  }

  func provideFavoriteGame() -> FavoriteGameUseCase {
    let repository = provideGameRepository()

    return FavoriteGameInteractor(repository: repository)
  }

  func provideOnboarding() -> UserUseCase {
    let repository = provideUserRepository()

    return UserInteractor(repository: repository)
  }

  func provideUser() -> UserUseCase {
    let repository = provideUserRepository()

    return UserInteractor(repository: repository)
  }

}
