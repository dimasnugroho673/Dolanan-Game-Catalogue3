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

    let detailPresenter = DetailGamePresenter(detailGameUseCase: detailGameUseCase)
    let favoritePresenter = FavoriteGamePresenter(favoriteGameUseCase: favoriteGameUseCase)

    return GameDetailView(id: id, game: game, detailPresenter: detailPresenter, favoriteGamePresenter: favoritePresenter)
  }

}
