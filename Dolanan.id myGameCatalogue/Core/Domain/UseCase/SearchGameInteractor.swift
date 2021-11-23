//
//  SearchInteractor.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import RxSwift

protocol SearchGameUseCase {
  func getGamesByKeyword(keyword: String) -> Observable<[GameModel]>
}

class SearchGameInteractor: SearchGameUseCase {
  
  private var repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGamesByKeyword(keyword: String) -> Observable<[GameModel]> {
    return repository.getGamesByKeyword(keyword: keyword)
  }
  
}
