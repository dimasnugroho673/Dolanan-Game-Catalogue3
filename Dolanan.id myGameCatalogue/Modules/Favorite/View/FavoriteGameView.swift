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
import Common

struct FavoriteGameView: View {

  @ObservedObject var favoriteGamePresenter: GetListPresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetFavoriteGameRepository<GetGamesLocaleDataSource, GameTransformer>>>

  @State var photoProfileUser: Data = Data()

  var body: some View {
    NavigationView {
      VStack {
        if favoriteGamePresenter.list.isEmpty {
          Text(LocalizedLang.emptyFavorite)
            .foregroundColor(.gray)
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(favoriteGamePresenter.list, id: \.id) { game in
              self.detailGameLinkBuilder(id: game.id ?? 0) {
                FavoriteGameCard(game: game)
                  .padding(.leading, 18)
                  .padding(.trailing, 18)
              }
              .padding(.bottom, 10)
            }
          }
        }
      }
      .onAppear {
        self.fetchFavoriteGames()

        photoProfileUser = UserDefaults.standard.data(forKey: "PhotoProfileUser") ?? Data()
      }

      .navigationTitle(LocalizedLang.favorite)
      .navigationBarTitleDisplayMode(.large)
      .navigationBarItems(trailing:
                            self.profileLinkBuilder {
        ProfilePictureNavbar(profileImageData: photoProfileUser)
      }
      )
    }
  }
}

extension FavoriteGameView {
  private func fetchFavoriteGames() {
    self.favoriteGamePresenter.getList(request: "")
  }

  private func detailGameLinkBuilder<Content: View>(
    id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: FavoriteGameRouter().makeDetailView(id: id)) { content() }
  }

  private func profileLinkBuilder<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().makeProfileView()) { content() }
  }
}
