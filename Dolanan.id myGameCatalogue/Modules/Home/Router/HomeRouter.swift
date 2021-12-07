//
//  HomeRouter.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import SwiftUI
import Game
import Core

class HomeRouter {

  func makeDetailView(id: Int) -> some View {

      let useCase: Interactor<Int, GameDetailDomainModel, GetGameRepository<GetGameRemoteDataSource, GameDetailTransformer>> = Injection.init().provideDetailGame()

      let detailPresenter = GetDetailPresenter(useCase: useCase)

      return GameDetailView(id: id, detailPresenter: detailPresenter)
  }

//  func makeDetailView(for game: GameModel, id: Int) -> some View {
//    let detailGameUseCase = Injection.init().provideDetailGame(game: game)
//    let favoriteGameUseCase = Injection.init().provideFavoriteGame()
//
//    let detailPresenter = DetailGamePresenter(detailGameUseCase: detailGameUseCase, favoriteGameUseCase: favoriteGameUseCase)
//
//    return GameDetailView(id: id, game: game, detailPresenter: detailPresenter)
//  }
  
  func makeProfileView() -> some View {
    let userUserCase = Injection.init().provideUser()

    let profilePresenter = ProfilePresenter(userUseCase: userUserCase)
    let editProfilePresenter = EditProfilePresenter(userUseCase: userUserCase)

    return ProfileView(profilePresenter: profilePresenter, editProfilePresenter: editProfilePresenter)
  }

}
