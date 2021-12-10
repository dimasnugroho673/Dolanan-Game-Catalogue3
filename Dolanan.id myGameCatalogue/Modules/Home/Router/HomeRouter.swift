//
//  HomeRouter.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI
import Game
import Core
import User

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
//    @ObservedObject var profilePresenter: GetDetailPresenter<Any, UserDomainModel, Interactor<Any, UserDomainModel, GetUserRepository<GetUserLocaleDataSource, UserTransformer>>>

    let userUseCase: Interactor<Any, UserDomainModel, GetUserRepository<GetUserLocaleDataSource, UserTransformer>> = Injection.init().provideUser()
    let editUserUseCase: Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>> = Injection.init().provideUpdateUser()

    let detailUserPresenter = GetDetailPresenter(useCase: userUseCase)
    let editUserPresenter = UserEditPresenter(userUseCase: editUserUseCase)

    return ProfileView(profilePresenter: detailUserPresenter, editProfilePresenter: editUserPresenter)
//    let userUserCase = Injection.init().provideUser()
//
//    let profilePresenter = ProfilePresenter(userUseCase: userUserCase)
//    let editProfilePresenter = EditProfilePresenter(userUseCase: userUserCase)
//
//    return ProfileView(profilePresenter: profilePresenter, editProfilePresenter: editProfilePresenter)
  }

}
