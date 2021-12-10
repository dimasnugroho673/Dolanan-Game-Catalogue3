//
//  HomeView.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI
import Core
import Game

struct HomeView: View {
  
  @ObservedObject var homePresenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>

  @State private var carouselIndex: Int = 0
  @State private var photoProfileUser: Data = Data()
  @State private var carousels: [CarouselModel] = []
  
  var body: some View {
    NavigationView {
      ZStack {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading) {
            
            if self.carousels.count > 0 {
              carouselContent
            }
            
            if homePresenter.isLoading {
              loadingIndicator
            } else {
              popularGameContent
            }
          }
          .padding(.bottom, 10)
          
        }
        .onAppear {
          self.fetchPopularGame()
          self.fetchCarousels()
          self.fetchPhotoProfileUser()
        }
        
        .navigationTitle("Home")
        .navigationBarItems(trailing:
                              self.profileLinkBuilder {
          ProfilePictureNavbar(profileImageData: photoProfileUser)
        }
        )
      }
    }
  }
  
}

extension HomeView {

  private var loadingIndicator: some View {
    HStack(alignment: .center) {
      Spacer()
      VStack {
        Spacer()
        LoadingState().padding(.top, 10)
        Text("LOADING").font(.caption).foregroundColor(.gray).padding(.top, 5)
        Spacer()
      }
      Spacer()
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2, alignment: .center)
  }

  private var carouselContent: some View {
    TabView(selection: self.$carouselIndex) {
      ForEach(self.carousels, id: \.id) { carousel in
        self.detailGameLinkBuilder(id: carousel.id) {
          Image(carousel.image)
            .resizable()
            .frame(height: 200)
            .cornerRadius(10)
            .padding(.horizontal)
            .tag(carouselIndex)
        }
      }
    }
    .frame(height: 200)
    .tabViewStyle(PageTabViewStyle())
    .animation(.easeOut)
  }

  private var popularGameContent: some View {
    VStack(alignment: .leading) {
      Text("Popular Game")
        .font(.title3)
        .bold()
        .padding(.top, 20)

      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 15) {
          ForEach(Array(homePresenter.list.enumerated()), id: \.1.id) { (index, game) in
            self.detailGameLinkBuilder(id: game.id ?? 0) {
              PopularGameCard2(game: game, isLastItem: (index == homePresenter.list.count - 1 ? true : false))
            }
          }
        }
      }
    }
    .padding(.horizontal, 15)
  }

  private func detailGameLinkBuilder<Content: View>(
    id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().makeDetailView(id: id)) { content() }
  }

  private func profileLinkBuilder<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().makeProfileView()) { content() }
  }

  private func fetchPopularGame() {
    if homePresenter.list.count == 0 {
      homePresenter.getList(request: nil)
    }
  }

  private func fetchCarousels() {
    carousels = dataCarousels
  }

  private func fetchPhotoProfileUser() {
    photoProfileUser = UserDefaults.standard.data(forKey: "PhotoProfileUser") ?? Data()
  }
}
