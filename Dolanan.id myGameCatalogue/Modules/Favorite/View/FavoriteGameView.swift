//
//  FavoriteGameView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Game

struct FavoriteGameView: View {

  @ObservedObject var favoriteGamePresenter: GetListPresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetFavoriteGameRepository<GetGamesLocaleDataSource, GameTransformer>>>
//  @ObservedObject var favoriteGamePresenter: FavoriteGamePresenter

  var body: some View {
    NavigationView {
      VStack {
        if favoriteGamePresenter.list.isEmpty {
          Text("No favorite added")
            .foregroundColor(.gray)
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(favoriteGamePresenter.list, id: \.id) { game in
//              favoriteGamePresenter.linkBuilder(for: game) {
                FavoriteGameCard(game: game)
                  .padding(.leading, 18)
                  .padding(.trailing, 18)
//              }
              .padding(.bottom, 10)
            }
          }
        }
      }
      .onAppear {
        favoriteGamePresenter.getList(request: "")
//        favoriteGamePresenter.getUser()
      }

      .navigationTitle("Favorite")
      .navigationBarTitleDisplayMode(.large)
//      .navigationBarItems(trailing:
//                            favoriteGamePresenter.linkToProfileView {
//        ProfilePictureNavbar(profileImageData: favoriteGamePresenter.user?.profilePicture ?? Data())
//      }
//      )
    }
  }
}
