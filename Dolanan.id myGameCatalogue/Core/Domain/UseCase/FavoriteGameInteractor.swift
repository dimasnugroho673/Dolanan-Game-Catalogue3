//
//  FavoriteInteractor.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import RxSwift

protocol FavoriteGameUseCase {
  func getFavoriteGames() -> Observable<[GameModel]>
}

class FavoriteGameInteractor: FavoriteGameUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteGames() -> Observable<[GameModel]> {
    return repository.getFavoriteGames()
  }


}
