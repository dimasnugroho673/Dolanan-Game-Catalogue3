//
//  ContentView.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI

struct ContentView: View {

  @EnvironmentObject var onboardingPresenter: OnboardingPresenter

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
