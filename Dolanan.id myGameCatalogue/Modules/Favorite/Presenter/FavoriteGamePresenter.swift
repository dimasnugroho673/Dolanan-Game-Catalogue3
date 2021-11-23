//
//  FavoritePresenter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import RxSwift
import SwiftUI

class FavoriteGamePresenter: ObservableObject {
  
  private let favoriteGameUseCase: FavoriteGameUseCase
  private let userUseCase: UserUseCase
  private let favoriteGameRouter = FavoriteGameRouter()
  
  @Published var user: UserModel?
  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true
  @Published var keywordCounter: String = ""
  @Published var deleteGameFromFavoriteStatus: Bool = false
  @Published var addGameToFavoriteStatus: Bool = false
  
  private let disposeBag = DisposeBag()
  
  init(favoriteGameUseCase: FavoriteGameUseCase, userUseCase: UserUseCase) {
    self.favoriteGameUseCase = favoriteGameUseCase
    self.userUseCase = userUseCase
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
  
  func getUser() {
    userUseCase.getUser()
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.user = result
      } onError: { error in
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
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
  
  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: favoriteGameRouter.makeDetailView(for: game)) { content() }
  }
  
  func linkToProfileView<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: favoriteGameRouter.makeProfileView()) { content() }
  }
  
}
