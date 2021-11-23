//
//  SearchRouter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import SwiftUI

class SearchGameRouter {

  func makeDetailView(for game: GameModel) -> some View {
    let detailGameUseCase = Injection.init().provideDetailGame(game: game)
    let favoriteGameUseCase = Injection.init().provideFavoriteGame()
    let userUserCase = Injection.init().provideUser()

    let detailPresenter = DetailGamePresenter(detailGameUseCase: detailGameUseCase, favoriteGameUseCase: favoriteGameUseCase)
    let favoritePresenter = FavoriteGamePresenter(favoriteGameUseCase: favoriteGameUseCase, userUseCase: userUserCase)

    return GameDetailView(game: game, detailPresenter: detailPresenter)
  }

  func makeProfileView() -> some View {
    let userUserCase = Injection.init().provideUser()

    let profilePresenter = ProfilePresenter(userUseCase: userUserCase)
    let editProfilePresenter = EditProfilePresenter(userUseCase: userUserCase)

    return ProfileView(profilePresenter: profilePresenter, editProfilePresenter: editProfilePresenter)
  }
  
}
