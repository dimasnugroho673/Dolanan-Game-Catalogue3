//
//  Injection.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

  func provideRepository() -> GameRepositoryProtocol {

    // realm injection
    let realm = try? Realm()

    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    let local: LocalDataSource = LocalDataSource.sharedInstance(realm)

    return GameRepository.sharedInstance(remote, local)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()

    return HomeInteractor(repository: repository)
  }

  func provideDetailGame(game: GameModel) -> DetailGameUseCase {
    let repository = provideRepository()

    return DetailGameInteractor(repository: repository, game: game)
  }

  func provideSearchGame() -> SearchGameUseCase {
    let repository = provideRepository()

    return SearchGameInteractor(repository: repository)
  }

  func provideFavoriteGame() -> FavoriteGameUseCase {
    let repository = provideRepository()

    return FavoriteGameInteractor(repository: repository)
  }

}
