//
//  ProfileView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import SwiftUI
import Core
import User
import Common

struct ProfileView: View {

  @Environment(\.presentationMode) var presentation
  @Environment(\.openURL) var openURL
  @Environment(\.colorScheme) var colorScheme

  @ObservedObject var profilePresenter: GetDetailPresenter<Any, UserDomainModel, Interactor<Any, UserDomainModel, GetUserRepository<GetUserLocaleDataSource, UserTransformer>>>
  @ObservedObject var editProfilePresenter: UserEditPresenter<Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>>>

  @State private var containerData: UserDomainModel = UserDomainModel(id: "", name: "", email: "", phoneNumber: "", website: "", githubUrl: "", profilePicture: Data())
  @State var isEditModalShow: Bool = false

  @State var profileImageData: Data = Data()
  @State var fullname: String = ""
  @State var email: String = ""
  @State var noHP: String = ""
  @State var website: String = ""
  @State var githubLink: String = ""
  
  var body: some View {
    ScrollView(.vertical) {
      ZStack(alignment: .top) {
        self.userDataContent
          .onAppear {
            /// fetch user data
            self.fetchUserData()

            self.fillUserContainerDataState()

            self.fillUserDataState()
          }
      }
    }
    .navigationTitle(LocalizedLang.profile).navigationBarTitleDisplayMode(.large)
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading:
                          Button(action: {
      self.presentation.wrappedValue.dismiss()
    }) {
      HStack {
        Image(systemName: "chevron.backward.circle.fill")
          .resizable()
          .frame(width: 30, height: 30)
          .foregroundColor(colorScheme == .light ? .black : .white)
      }
    },
                        trailing:
                          Button(action: {
      self.isEditModalShow = true
    }, label: {
      Text(LocalizedLang.edit)
    })
                          .sheet(isPresented: $isEditModalShow, onDismiss: {
      /// fetch user data
      self.fetchUserData()

      /// fill state variable with data
      self.fillUserDataState()
    }, content: {
      EditProfileView(user: self.containerData, editProfilePresenter: editProfilePresenter)
    })
    )
  }
}

extension ProfileView {

  private var userDataContent: some View {
    VStack {
      VStack {

        if self.profileImageData != Data() {
          let decoded = (try? PropertyListDecoder().decode(Data.self, from: self.profileImageData)) ?? Data()

          Image(uiImage: UIImage(data: decoded)!)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
        } else {
          Image("my-profile")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
        }

        Text(self.fullname)
          .font(.title2)
          .fontWeight(.bold)
          .padding(.top, 10)
      }
      .padding(.top, 20)

      Spacer().frame(height: 30)

      VStack(alignment: .leading, spacing: 12) {
        HStack {
          Image(systemName: "envelope")
          Text(self.email)
        }

        HStack {
          Image(systemName: "phone")
          Text(self.noHP)
        }

        HStack {
          Image(systemName: "network")
          Text(self.website)
        }
      }

      Spacer().frame(height: 50)

      if self.githubLink != "" {
        Button(action: {
          openURL(URL(string: self.githubLink)!)
        }) {
          HStack {
            Spacer()
            HStack {
              Image(colorScheme == .light ? "icon-github_white" : "icon-github_black")
                .resizable()
                .frame(width: 25, height: 25)

              Text(LocalizedLang.viewOnGithub)
                .font(.callout)
                .fontWeight(.bold)
                .padding()
            }

            Spacer()
          }
        }
        .frame(width: 230, height: 50)
        .background(colorScheme == .light ? Color.black : Color.white)
        .foregroundColor(colorScheme == .light ? Color.white : Color.black)
        .cornerRadius(15)
      }

    }
  }

  private func fetchUserData() {
    self.profilePresenter.getDetail(request: nil)
  }

  private func fillUserDataState() {
    self.fullname = profilePresenter.detail?.name ?? ""
    self.email = profilePresenter.detail?.email ?? ""
    self.noHP = profilePresenter.detail?.phoneNumber ?? ""
    self.website = profilePresenter.detail?.website ?? ""
    self.githubLink = profilePresenter.detail?.githubUrl ?? ""
    self.profileImageData = profilePresenter.detail?.profilePicture ?? Data()
  }

  private func fillUserContainerDataState() {
    self.containerData = profilePresenter.detail ?? UserDomainModel(id: "", name: "", email: "", phoneNumber: "", website: "", githubUrl: "", profilePicture: Data())
  }
}
