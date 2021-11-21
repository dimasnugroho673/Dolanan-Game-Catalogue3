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

    let detailPresenter = DetailGamePresenter(detailGameUseCase: detailGameUseCase)
    let favoritePresenter = FavoriteGamePresenter(favoriteGameUseCase: favoriteGameUseCase)

    return GameDetailView(game: game, detailPresenter: detailPresenter, favoriteGamePresenter: favoritePresenter)
  }

}
