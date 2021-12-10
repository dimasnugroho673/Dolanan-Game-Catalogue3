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

  @State var carouselIndex: Int = 0
  @State var photoProfileUser: Data = Data()
  @State var carousels: [CarouselModel] = []
  
  var body: some View {
    NavigationView {
      ZStack {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading) {
            
            if self.carousels.count > 0 {
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
            
            if homePresenter.isLoading {
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
            } else {
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
          }
          .padding(.bottom, 10)
          
        }
        .onAppear {
          if homePresenter.list.count == 0 {
            homePresenter.getList(request: nil)
          }

          photoProfileUser = UserDefaults.standard.data(forKey: "PhotoProfileUser") ?? Data()

          self.fetchCarousels()
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

  private func fetchCarousels() {
    carousels = dataCarousels
  }
  
}

extension HomeView {
  func detailGameLinkBuilder<Content: View>(
    id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().makeDetailView(id: id)) { content() }
  }

  func profileLinkBuilder<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().makeProfileView()) { content() }
  }
}
