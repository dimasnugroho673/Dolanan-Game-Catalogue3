//
//  TabBarView.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI
import Core
import Game
import Common

struct TabBarView: View {
  
  @EnvironmentObject var homePresenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  @EnvironmentObject var searchGamePresenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  @EnvironmentObject var favoriteGamePresenter: GetListPresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetFavoriteGameRepository<GetGamesLocaleDataSource, GameTransformer>>>
  
  var body: some View {
    TabView {
      HomeView(homePresenter: homePresenter)
        .tabItem {
          Image(systemName: "house")
          Text(LocalizedLang.home)
        }
      
      SearchGameView(searchGamePresenter: searchGamePresenter)
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text(LocalizedLang.search)
        }
      
      FavoriteGameView(favoriteGamePresenter: favoriteGamePresenter)
        .tabItem {
          Image(systemName: "text.badge.star")
          Text(LocalizedLang.favorite)
        }
    }
  }
}

struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}
