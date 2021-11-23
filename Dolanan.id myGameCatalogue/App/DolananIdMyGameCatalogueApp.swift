//
//  Dolanan_id_myGame_CatalogueApp.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI

@main
struct DolananIdMyGameCatalogueApp: App {

  let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome(), userUseCase: Injection.init().provideUser())
  let searchGamePresenter = SearchGamePresenter(searchGameUseCase: Injection.init().provideSearchGame(), userUseCase: Injection.init().provideUser())
  let favoriteGamePresenter = FavoriteGamePresenter(favoriteGameUseCase: Injection.init().provideFavoriteGame(), userUseCase: Injection.init().provideUser())
  let onboardingPresenter = OnboardingPresenter(userUseCase: Injection.init().provideOnboarding())
  let profilePresenter = ProfilePresenter(userUseCase: Injection.init().provideUser())
  let editProfilePresenter = EditProfilePresenter(userUseCase: Injection.init().provideUser())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(searchGamePresenter)
        .environmentObject(favoriteGamePresenter)
        .environmentObject(onboardingPresenter)
        .environmentObject(profilePresenter)
    }
  }
}
