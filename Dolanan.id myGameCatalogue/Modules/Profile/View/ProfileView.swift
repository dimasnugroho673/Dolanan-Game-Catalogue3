//
//  ProfileView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import SwiftUI
import Core
import User

struct ProfileView: View {

  @Environment(\.presentationMode) var presentation
  @Environment(\.openURL) var openURL
  @Environment(\.colorScheme) var colorScheme

  @State var isEditModalShow: Bool = false

//  @ObservedObject var profilePresenter: ProfilePresenter
  //  @ObservedObject var detailPresenter: GetDetailPresenter<Int, GameDetailDomainModel, Interactor<Int, GameDetailDomainModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>>
  @ObservedObject var profilePresenter: GetDetailPresenter<Any, UserDomainModel, Interactor<Any, UserDomainModel, GetUserRepository<GetUserLocaleDataSource, UserTransformer>>>
  @ObservedObject var editProfilePresenter: UserEditPresenter<Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>>>

  @State var profileImageData: Data = Data()
  @State var fullname: String = ""
  @State var email: String = ""
  @State var noHP: String = ""
  @State var website: String = ""
  @State var githubLink: String = ""
  
  var body: some View {
    ScrollView(.vertical) {
      ZStack(alignment: .top) {
        VStack {
          VStack {

            if profilePresenter.detail?.profilePicture ?? Data() != Data() {
              let decoded = (try? PropertyListDecoder().decode(Data.self, from: profilePresenter.detail!.profilePicture!)) ?? Data()

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

            Text(profilePresenter.detail?.name ?? "")
              .font(.title2)
              .fontWeight(.bold)
              .padding(.top, 10)
          }
          .padding(.top, 20)

          Spacer().frame(height: 30)

          VStack(alignment: .leading, spacing: 12) {
            HStack {
              Image(systemName: "envelope")
              Text(profilePresenter.detail?.email ?? "")
            }

            HStack {
              Image(systemName: "phone")
              Text(profilePresenter.detail?.phoneNumber ?? "")
            }

            HStack {
              Image(systemName: "network")
              Text(profilePresenter.detail?.website ?? "")
            }
          }

          Spacer().frame(height: 50)

          if profilePresenter.detail?.githubUrl ?? "" != "" {
            Button(action: {
              openURL(URL(string: profilePresenter.detail?.githubUrl ?? "")!)
            }) {
              HStack {
                Spacer()
                HStack {
                  Image(colorScheme == .light ? "icon-github_white" : "icon-github_black")
                    .resizable()
                    .frame(width: 25, height: 25)

                  Text("View on GitHub")
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
        .onAppear {
          /// fetch user data
          self.profilePresenter.getDetail(request: nil)
        }
      }
    }
    .navigationTitle("Profile").navigationBarTitleDisplayMode(.large)
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
      Text("Edit")
    })
     .sheet(isPresented: $isEditModalShow, onDismiss: {
      self.profilePresenter.getDetail(request: nil)

      /// fill state variable with data
      self.fullname = profilePresenter.detail?.name ?? ""
      self.email = profilePresenter.detail?.email ?? ""
      self.noHP = profilePresenter.detail?.phoneNumber ?? ""
      self.website = profilePresenter.detail?.website ?? ""
      self.githubLink = profilePresenter.detail?.githubUrl ?? ""
      self.profileImageData = profilePresenter.detail?.profilePicture ?? Data()
    }, content: {
      EditProfileView(user: profilePresenter.detail, editProfilePresenter: editProfilePresenter)
    })
    )
  }
}
