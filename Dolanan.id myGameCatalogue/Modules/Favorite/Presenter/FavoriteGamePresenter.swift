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
  private let favoriteGameRouter = FavoriteGameRouter()

  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true
  @Published var keywordCounter: String = ""

  private let disposeBag = DisposeBag()

  init(favoriteGameUseCase: FavoriteGameUseCase) {
    self.favoriteGameUseCase = favoriteGameUseCase
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

  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: favoriteGameRouter.makeDetailView(for: game)) { content() }
  }

}
