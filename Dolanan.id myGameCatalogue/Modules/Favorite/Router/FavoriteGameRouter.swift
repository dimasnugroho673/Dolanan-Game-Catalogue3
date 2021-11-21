//
//  FavoriteGameRouter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import SwiftUI

class FavoriteGameRouter {

  func makeDetailView(for game: GameModel) -> some View {
    let detailGameUseCase = Injection.init().provideDetailGame(game: game)
    let presenter = DetailGamePresenter(detailGameUseCase: detailGameUseCase)

    return GameDetailView(game: game, detailPresenter: presenter)
  }

}
