//
//  TabBarView.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI
import Core
import Game

struct TabBarView: View {

  @EnvironmentObject var homePresenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  @EnvironmentObject var searchGamePresenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
//  @EnvironmentObject var searchGamePresenter: SearchGamePresenter
  @EnvironmentObject var favoriteGamePresenter: FavoriteGamePresenter

  var body: some View {
    TabView {
      HomeView(homePresenter: homePresenter)
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }

      SearchGameView(searchGamePresenter: searchGamePresenter)
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }

      FavoriteGameView(favoriteGamePresenter: favoriteGamePresenter)
        .tabItem {
          Image(systemName: "text.badge.star")
          Text("Favorite")
        }
    }
  }
}

struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}
