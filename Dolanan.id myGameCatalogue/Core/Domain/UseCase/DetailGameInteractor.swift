//
//  DetailInteractor.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import RxSwift

protocol DetailGameUseCase {
  func getGameDetail(id: Int) -> Observable<GameDetailModel>
}

class DetailGameInteractor: DetailGameUseCase {
  
  private let repository: GameRepositoryProtocol
  private let game: GameModel
  
  required init(repository: GameRepositoryProtocol, game: GameModel) {
    self.repository = repository
    self.game = game
  }
  
  func getGameDetail(id: Int) -> Observable<GameDetailModel> {
    return repository.getDetailGame(id: id)
  }
  
}
