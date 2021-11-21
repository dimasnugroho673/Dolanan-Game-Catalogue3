//
//  HomeView.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI

struct HomeView: View {

  @ObservedObject var homePresenter: HomePresenter

  @State var carouselIndex: Int = 0

    var body: some View {
      NavigationView {
        ZStack {
          ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {

              if homePresenter.carousels.count > 0 {
                TabView(selection: self.$carouselIndex) {
                  ForEach(homePresenter.carousels, id: \.id) { carousel in
  //                  NavigationLink(destination: GameDetailView(id: carousel.id)) {
                      Image(carousel.image)
                        .resizable()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .tag(carouselIndex)
  //                  }
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
                    .padding(.leading, 15)
                    .padding(.top, 20)

                  ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                      ForEach(Array(homePresenter.popularGames.enumerated()), id: \.1.id) { (index, game) in
                        homePresenter.linkBuilder(for: game) {
                          PopularGameCard(game: game, isLastItem: (index == homePresenter.popularGames.count - 1 ? true : false))
                        }
                      }
                    }
                  }
                }
//                PopularGameRow(popularGames: popularGames.dataPopularGame)
//                  .padding(.top, 20)
//
//                CreatorRow(creators: creatorsData.dataCreators)
//                  .padding(.top, 20)

              }
            }
            .padding(.bottom, 10)

          }
          .onAppear {
            if homePresenter.popularGames.count == 0 {
              homePresenter.getPopularGames()
            }

            homePresenter.getCarousels()
          }
          .navigationTitle("Home")
//          .navigationBarItems(trailing:
//                                NavigationLink(destination: ProfileView()) {
//                                  ProfilePictureNavbar()
//                                })
        }
      }
    }
    
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
