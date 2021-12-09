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

//          let useCase: Interactor<Int, GameDetailDomainModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>> = Injection.init().provideDetailGame()
//          let detailPresenter = GetDetailPresenter(useCase: useCase)
//
//          return GameDetailView(id: id, detailPresenter: detailPresenter)

//    @ObservedObject var detailPresenter: GameDetailPresenter<
//      Interactor<Int, GameDetailDomainModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>,
//      Interactor<GameDomainModel, Bool, UpdateFavoriteGameRepository<GetGamesLocaleDataSource, GameTransformer>>
//    >

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
    let userUserCase = Injection.init().provideUser()

    let profilePresenter = ProfilePresenter(userUseCase: userUserCase)
    let editProfilePresenter = EditProfilePresenter(userUseCase: userUserCase)

    return ProfileView(profilePresenter: profilePresenter, editProfilePresenter: editProfilePresenter)
  }

}
