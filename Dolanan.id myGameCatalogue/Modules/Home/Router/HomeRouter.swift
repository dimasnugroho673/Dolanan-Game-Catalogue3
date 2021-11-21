//
//  HomeRouter.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import SwiftUI

class HomeRouter {

  func makeDetailView(for game: GameModel) -> some View {
    let detailGameUseCase = Injection.init().provideDetailGame(game: game)
    let presenter = DetailGamePresenter(detailGameUseCase: detailGameUseCase)

    return GameDetailView(game: game, detailPresenter: presenter)
  }

}
