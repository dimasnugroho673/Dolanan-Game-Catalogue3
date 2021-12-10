//
//  FavoriteGameRouter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import SwiftUI
import Game
import Core
import User

class FavoriteGameRouter {
  
  func makeDetailView(id: Int) -> some View {
    let gameUseCase: Interactor<Int, GameDetailDomainModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>> = Injection.init().provideDetailGame()

    let favoriteGameUseCase: Interactor<
      GameDomainModel,
      Bool,
      UpdateFavoriteGameRepository<
        GetGamesLocaleDataSource,
        GameTransformer>
    > = Injection.init().provideUpdateFavoriteGame()
    
    let presenter = GameDetailPresenter(gameUseCase: gameUseCase, favoriteGameUseCase: favoriteGameUseCase)

    return GameDetailView(id: id, detailPresenter: presenter)
  }
  
  func makeProfileView() -> some View {
    let userUseCase: Interactor<Any, UserDomainModel, GetUserRepository<GetUserLocaleDataSource, UserTransformer>> = Injection.init().provideUser()
    let editUserUseCase: Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>> = Injection.init().provideUpdateUser()

    let detailUserPresenter = GetDetailPresenter(useCase: userUseCase)
    let editUserPresenter = UserEditPresenter(userUseCase: editUserUseCase)

    return ProfileView(profilePresenter: detailUserPresenter, editProfilePresenter: editUserPresenter)
  }
  
}
