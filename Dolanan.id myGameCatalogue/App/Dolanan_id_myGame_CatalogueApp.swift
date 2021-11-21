//
//  Dolanan_id_myGame_CatalogueApp.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI

@main
struct Dolanan_id_myGame_CatalogueApp: App {

  let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
  let searchGamePresenter = SearchGamePresenter(searchGameUseCase: Injection.init().provideSearchGame())
  let favoriteGamePresenter = FavoriteGamePresenter(favoriteGameUseCase: Injection.init().provideFavoriteGame())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(searchGamePresenter)
        .environmentObject(favoriteGamePresenter)
    }
  }
}
