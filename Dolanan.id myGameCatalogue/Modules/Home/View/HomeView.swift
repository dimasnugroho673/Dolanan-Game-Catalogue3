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
                  homePresenter.linkBuilder(for: nil, id: carousel.id) {
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
                  .padding(.leading, 15)
                  .padding(.top, 20)

                ScrollView(.vertical, showsIndicators: false) {
                  VStack(alignment: .leading, spacing: 15) {
                    ForEach(Array(homePresenter.popularGames.enumerated()), id: \.1.id) { (index, game) in
                      homePresenter.linkBuilder(for: game, id: 0) {
                        PopularGameCard2(game: game, isLastItem: (index == homePresenter.popularGames.count - 1 ? true : false))
                      }
                    }
                  }
                }

//                ScrollView(.horizontal, showsIndicators: false) {
//                  HStack(alignment: .top) {
//                    ForEach(Array(homePresenter.popularGames.enumerated()), id: \.1.id) { (index, game) in
//                      homePresenter.linkBuilder(for: game, id: 0) {
//                        PopularGameCard(game: game, isLastItem: (index == homePresenter.popularGames.count - 1 ? true : false))
//                      }
//                    }
//                  }
//                }
              }
            }
          }
          .padding(.bottom, 10)

        }
        .onAppear {
          if homePresenter.popularGames.count == 0 {
            homePresenter.getPopularGames()
          }

          homePresenter.getCarousels()
          homePresenter.getUser()
        }
        
        .navigationTitle("Home")
        .navigationBarItems(trailing:
            homePresenter.linkToProfileView {
            ProfilePictureNavbar(profileImageData: homePresenter.user?.profilePicture ?? Data())
          }
        )
      }
    }
  }

}
