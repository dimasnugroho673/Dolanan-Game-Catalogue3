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
  
  @ObservedObject var homePresenter: GetListPresenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  
  @State var carouselIndex: Int = 0
  @State var carousels: [CarouselModel] = [
    CarouselModel(id: 41494, title: "Cyberpunk 2077", image: "carousel"),
    CarouselModel(id: 10061, title: "Watch Dogs 2", image: "carousel4"),
    CarouselModel(id: 2828, title: "Naruto Ultimate Ninja Storm 4", image: "carousel3"),
    CarouselModel(id: 452645, title: "Hitman 3", image: "carousel2"),
    CarouselModel(id: 437059, title: "Assassin's Creed Valhalla", image: "carousel5")
  ]
  
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
          
//          homePresenter.getCarousels()
//          homePresenter.getUser()
        }
        
        .navigationTitle("Home")
//        .navigationBarItems(trailing:
//                              homePresenter.linkToProfileView {
//          ProfilePictureNavbar(profileImageData: homePresenter.user?.profilePicture ?? Data())
//        }
//        )
      }
    }
  }
  
}

extension HomeView {
  func detailGameLinkBuilder<Content: View>(
    id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().makeDetailView(id: id)) { content() }
  }
}
