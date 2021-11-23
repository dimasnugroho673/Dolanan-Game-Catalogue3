//
//  SearchGamePresenter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import RxSwift
import SwiftUI

class SearchGamePresenter: ObservableObject {

  private let searchGameUseCase: SearchGameUseCase
  private let userUseCase: UserUseCase
  private let searchRouter = SearchGameRouter()

  @Published var user: UserModel?
  @Published var resultGames: [GameModel] = []
  @Published var topRatingGames: [TopRatingGamesModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true
  @Published var keywordCounter: String = ""

  private let disposeBag = DisposeBag()

  init(searchGameUseCase: SearchGameUseCase, userUseCase: UserUseCase) {
    self.searchGameUseCase = searchGameUseCase
    self.userUseCase = userUseCase
  }

  func getGamesByKeyword(keyword: String) {
    isLoading = true
    searchGameUseCase.getGamesByKeyword(keyword: keyword)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.resultGames = result
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

  func getTopRatingGames() {
    topRatingGames = [
      TopRatingGamesModel(title: "Cyberpunk 2077"),
      TopRatingGamesModel(title: "Final Fantasy VII Remake Intergrade"),
      TopRatingGamesModel(title: "Hitman 3"),
      TopRatingGamesModel(title: "Watch Dogs 2"),
      TopRatingGamesModel(title: "Assassin's Creed Valhalla")
    ]
  }

  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: searchRouter.makeDetailView(for: game)) { content() }
  }

  func linkToProfileView<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: searchRouter.makeProfileView()) { content() }
  }
}
