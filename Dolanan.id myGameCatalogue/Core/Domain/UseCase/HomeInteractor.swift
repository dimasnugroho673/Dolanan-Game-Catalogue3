//
//  HomeInteractor.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import Combine
import RxSwift

//protocol HomeUseCase {
//  func getPopularGames() -> AnyPublisher<[PopularGame], Error>
//}
//
//class HomeInteractor: HomeUseCase {
//  private let repository: GameRepositoryProtocol
//
//  required init() {
//
//  }
//}

protocol HomeUseCase {
  func getPopularGames() -> Observable<[GameModel]>
}

class HomeInteractor: HomeUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getPopularGames() -> Observable<[GameModel]> {
    return repository.getPopularGames()
  }
}
