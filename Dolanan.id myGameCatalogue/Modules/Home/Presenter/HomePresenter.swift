//
//  HomePresenter.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import RxSwift
import SwiftUI

class HomePresenter: ObservableObject {
  
  private let homeUseCase: HomeUseCase
  private let userUseCase: UserUseCase
  private let homeRouter = HomeRouter()
  
  @Published var user: UserModel?
  @Published var popularGames: [GameModel] = []
  @Published var carousels: [CarouselModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  
  private let disposeBag = DisposeBag()
  
  init(homeUseCase: HomeUseCase, userUseCase: UserUseCase) {
    self.homeUseCase = homeUseCase
    self.userUseCase = userUseCase
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
  
  func getPopularGames() {
    isLoading = true
    homeUseCase.getPopularGames()
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.popularGames = result
      } onError: { error in
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
        self.isLoading = false
      }.disposed(by: disposeBag)
  }
  
  func getCarousels() {
    self.carousels = [
      CarouselModel(id: 41494, title: "Cyberpunk 2077", image: "carousel"),
      CarouselModel(id: 10061, title: "Watch Dogs 2", image: "carousel4"),
      CarouselModel(id: 2828, title: "Naruto Ultimate Ninja Storm 4", image: "carousel3"),
      CarouselModel(id: 452645, title: "Hitman 3", image: "carousel2"),
      CarouselModel(id: 437059, title: "Assassin's Creed Valhalla", image: "carousel5")
    ]
  }
  
//  func linkBuilder<Content: View>(
//    for game: GameModel?,
//    id: Int,
//    @ViewBuilder content: () -> Content
//  ) -> some View {
//    NavigationLink(destination: homeRouter.makeDetailView(for: game ?? GameModel(id: 0, name: "", released: "", backgroundImage: "", rating: 0.0, genres: nil, screenshots: nil), id: id)) { content() }
//  }
  
  func linkToProfileView<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: homeRouter.makeProfileView()) { content() }
  }
  
}
