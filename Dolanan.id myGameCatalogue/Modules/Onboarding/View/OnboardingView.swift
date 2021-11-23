//
//  OnboardingView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import SwiftUI

struct OnboardingView: View {
  
  @ObservedObject var onboardingPresenter: OnboardingPresenter
  
  @Environment(\.presentationMode) private var presentation
  @State private var activeImage = 0
  @Binding var isUserExist: Bool
  
  private let timerShowcase = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack {
      Image(onboardingPresenter.images[activeImage])
        .resizable()
        .aspectRatio(contentMode: .fill)
        .animation(.spring())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(
          Rectangle()
            .fill(
              LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom))
            .opacity(0.7)
        )
        .onReceive(timerShowcase) { _ in
          self.activeImage = (self.activeImage + 1) % self.onboardingPresenter.images.count
        }
      
      HStack {
        VStack {
          Text("Find your best game")
            .foregroundColor(.white)
            .font(.title)
            .bold()
          
          Text("Explore - Discover - Play")
            .foregroundColor(Color.init(.systemGray3))
            .font(.subheadline)
            .padding(.top, 5)
          
          Button(action: {
            UserDefaults.standard.setValue(true, forKey: "UserExist")
            
            /// insert data dummy
            onboardingPresenter.createUser(data: UserModel(id: "0", name: "Dimas Nugroho Putro", email: "dimasnugroho673@gmail.com", phoneNumber: "082285592029", website: "dimasnugroho673.github.io", githubUrl: "https://github.com/dimasnugroho673", profilePicture: Data()))
            
            self.isUserExist = true
            self.presentation.wrappedValue.dismiss()
          }, label: {
            Text("Get started")
              .font(.body)
              .fontWeight(.bold)
          })
            .buttonStyle(StartOnboardingButtonStyle())
            .padding(.top, 20)
        }
        .padding()
      }
      .padding(.bottom, 20)
      .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
    }
    .ignoresSafeArea(.all)
  }
}
