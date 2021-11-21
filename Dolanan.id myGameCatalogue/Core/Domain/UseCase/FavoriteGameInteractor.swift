//
//  FavoriteInteractor.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import RxSwift

protocol FavoriteGameUseCase {
  func addGameToFavorite(data: GameModel) -> Observable<Bool>
  func getFavoriteGames() -> Observable<[GameModel]>
  func removeGameFromFavorite(id: Int) -> Observable<Bool>
}

class FavoriteGameInteractor: FavoriteGameUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func addGameToFavorite(data: GameModel) -> Observable<Bool> {
    return repository.addGameToFavorite(data: data)
  }

  func getFavoriteGames() -> Observable<[GameModel]> {
    return repository.getFavoriteGames()
  }

  func removeGameFromFavorite(id: Int) -> Observable<Bool> {
    return repository.removeGameFromFavorite(id: id)
  }

}
