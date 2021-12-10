//
//  ContentView.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI
import Core
import User

struct ContentView: View {

//  @ObservedObject var detailPresenter: GameDetailPresenter<
//    Interactor<Int, GameDetailDomainModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>,
//    Interactor<GameDomainModel, Bool, UpdateFavoriteGameRepository<GetGamesLocaleDataSource, GameTransformer>>
//  >

  @EnvironmentObject var onboardingPresenter: UserEditPresenter<Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>>>

  @State private var isUserExist = UserDefaults.standard.bool(forKey: "UserExist")
  @State private var isOnboardingPresent = true

  var body: some View {
    if isUserExist {
      TabBarView()
    } else {
      VStack {}
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .background(Color.white)
      .edgesIgnoringSafeArea(.all)
      .fullScreenCover(isPresented: $isOnboardingPresent, content: {
//        Text("onboarding")
        OnboardingView(onboardingPresenter: onboardingPresenter, isUserExist: $isUserExist)
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
