//
//  DetailGamePresenter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import RxSwift

class DetailGamePresenter: ObservableObject {

  private let detailGameUseCase: DetailGameUseCase
  private let favoriteGameUseCase: FavoriteGameUseCase

  @Published var games: [GameModel] = []
  @Published var gameDetail: GameDetailModel?
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true
  @Published var deleteGameFromFavoriteStatus: Bool = false
  @Published var addGameToFavoriteStatus: Bool = false

  private let disposeBag = DisposeBag()

  init(detailGameUseCase: DetailGameUseCase, favoriteGameUseCase: FavoriteGameUseCase) {
    self.detailGameUseCase = detailGameUseCase
    self.favoriteGameUseCase = favoriteGameUseCase
  }

  func getGameDetail(id: Int) {
    isLoading = true
    detailGameUseCase.getGameDetail(id: id)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.gameDetail = result
      } onError: { error in
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
        self.isLoading = false
      }.disposed(by: disposeBag)
  }

  func getFavoriteGames() {
    isLoading = true
    favoriteGameUseCase.getFavoriteGames()
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.games = result
      } onError: { error in
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
        self.isLoading = false
      }.disposed(by: disposeBag)
  }

  func addGameToFavorite(data: GameModel) {
    favoriteGameUseCase.addGameToFavorite(data: data)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.addGameToFavoriteStatus = result
      } onError: { _ in
        self.errorMessage = "cannot added to favorite"
      } onCompleted: {
      }.disposed(by: disposeBag)
  }

  func removeGameFromFavorite(id: Int) {
    favoriteGameUseCase.removeGameFromFavorite(id: id)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
          self.deleteGameFromFavoriteStatus = result
      } onError: { _ in
          self.errorMessage = "Failed to save detail restaurant"
      } onCompleted: {
      }.disposed(by: disposeBag)
  }

}
