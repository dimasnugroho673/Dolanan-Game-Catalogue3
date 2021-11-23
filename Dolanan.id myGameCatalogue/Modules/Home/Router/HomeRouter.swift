//
//  HomeRouter.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import SwiftUI

class HomeRouter {

  func makeDetailView(for game: GameModel, id: Int) -> some View {
    let detailGameUseCase = Injection.init().provideDetailGame(game: game)
    let favoriteGameUseCase = Injection.init().provideFavoriteGame()
    let userUserCase = Injection.init().provideUser()

    let detailPresenter = DetailGamePresenter(detailGameUseCase: detailGameUseCase, favoriteGameUseCase: favoriteGameUseCase)
    let favoritePresenter = FavoriteGamePresenter(favoriteGameUseCase: favoriteGameUseCase, userUseCase: userUserCase)

    return GameDetailView(id: id, game: game, detailPresenter: detailPresenter)
  }

  func makeProfileView() -> some View {
    let userUserCase = Injection.init().provideUser()

    let profilePresenter = ProfilePresenter(userUseCase: userUserCase)
    let editProfilePresenter = EditProfilePresenter(userUseCase: userUserCase)

    return ProfileView(profilePresenter: profilePresenter, editProfilePresenter: editProfilePresenter)
  }

}
