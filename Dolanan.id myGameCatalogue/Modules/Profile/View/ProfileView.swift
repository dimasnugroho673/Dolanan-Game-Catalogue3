//
//  ProfileView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import SwiftUI

struct ProfileView: View {

  @Environment(\.presentationMode) var presentation
  @Environment(\.openURL) var openURL
  @Environment(\.colorScheme) var colorScheme

  @State var isEditModalShow: Bool = false

  @ObservedObject var profilePresenter: ProfilePresenter
  @ObservedObject var editProfilePresenter: EditProfilePresenter

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

            if profilePresenter.user?.profilePicture ?? Data() != Data() {
              let decoded = (try? PropertyListDecoder().decode(Data.self, from: profilePresenter.user!.profilePicture!)) ?? Data()

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

            Text(profilePresenter.user?.name ?? "")
              .font(.title2)
              .fontWeight(.bold)
              .padding(.top, 10)
          }
          .padding(.top, 20)

          Spacer().frame(height: 30)

          VStack(alignment: .leading, spacing: 12) {
            HStack {
              Image(systemName: "envelope")
              Text(profilePresenter.user?.email ?? "")
            }

            HStack {
              Image(systemName: "phone")
              Text(profilePresenter.user?.phoneNumber ?? "")
            }

            HStack {
              Image(systemName: "network")
              Text(profilePresenter.user?.website ?? "")
            }
          }

          Spacer().frame(height: 50)

          if profilePresenter.user?.githubUrl ?? "" != "" {
            Button(action: {
              openURL(URL(string: profilePresenter.user?.githubUrl ?? "")!)
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
          self.profilePresenter.getUser()
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
      self.profilePresenter.getUser()

      /// fill state variable with data from environtment object after fetchItem()
      self.fullname = profilePresenter.user?.name ?? ""
      self.email = profilePresenter.user?.email ?? ""
      self.noHP = profilePresenter.user?.phoneNumber ?? ""
      self.website = profilePresenter.user?.website ?? ""
      self.githubLink = profilePresenter.user?.githubUrl ?? ""
      self.profileImageData = profilePresenter.user?.profilePicture ?? Data()
    }, content: {
      EditProfileView(user: profilePresenter.user, editProfilePresenter: editProfilePresenter)
    })
    )
  }
}

//struct ProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    ProfileView()
//  }
//}
