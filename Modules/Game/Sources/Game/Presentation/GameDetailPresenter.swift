//
//  File.swift
//  
//
//  Created by Dimas Putro on 08/12/21.
//

import SwiftUI
import RxSwift
import Core

public class GameDetailPresenter<GameUseCase: UseCase, FavoriteGameUseCase: UseCase>: ObservableObject
where
GameUseCase.Request == Int, GameUseCase.Response == GameDetailDomainModel,
FavoriteGameUseCase.Request == GameDomainModel, FavoriteGameUseCase.Response == Bool {

  private let disposeBag = DisposeBag()

  private let _gameUseCase: GameUseCase
  private let _favoriteGameUseCase: FavoriteGameUseCase

  private let _keyStoreFavoriteGames: String = "FavoriteGames"

  @Published public var detail: GameDetailDomainModel?
  @Published public var favoriteGames: [Int] = [0]
  @Published public var isFavorite: Bool = false
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(gameUseCase: GameUseCase, favoriteGameUseCase: FavoriteGameUseCase) {
    _gameUseCase = gameUseCase
    _favoriteGameUseCase = favoriteGameUseCase

    self.getFavoriteGames()
  }

  public func getDetail(request: GameUseCase.Request) {
    isLoading = true
    _gameUseCase.execute(request: request)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.detail = result
      } onError: { error in
        print(String(describing: error.localizedDescription))
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
        self.isLoading = false
      }.disposed(by: disposeBag)
  }

  public func addGameToFavorite(request: FavoriteGameUseCase.Request) {
    _favoriteGameUseCase.execute(request: request)
      .observe(on: MainScheduler.instance)
      .subscribe { _ in
        self.favoriteGames.append(request.id ?? 0)

        self.saveFavoriteGames()

        self.getFavoriteGames()
      } onError: { error in
        print(String(describing: error.localizedDescription))
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
      }.disposed(by: disposeBag)
  }

  public func removeGameFromFavorite(request: FavoriteGameUseCase.Request) {
    _favoriteGameUseCase.execute(request: request)
      .observe(on: MainScheduler.instance)
      .subscribe { _ in
        self.getFavoriteGames()

        let index = self.favoriteGames.firstIndex(of: request.id ?? 0)
        self.favoriteGames.remove(at: index ?? 0)

        self.saveFavoriteGames()
        self.getFavoriteGames()
      } onError: { error in
        print(String(describing: error.localizedDescription))
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
      }.disposed(by: disposeBag)
  }

  private func getFavoriteGames() {
    favoriteGames = UserDefaults.standard.object(forKey: self._keyStoreFavoriteGames) as? [Int] ?? [0]
  }

  private func saveFavoriteGames() {
    UserDefaults.standard.set(self.favoriteGames, forKey: self._keyStoreFavoriteGames)
  }

}
