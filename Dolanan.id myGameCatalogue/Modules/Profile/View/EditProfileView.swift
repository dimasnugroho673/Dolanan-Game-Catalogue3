//
//  EditProfileView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import SwiftUI
import User
import Core
import Common

struct EditProfileView: View {
  
  @Environment(\.presentationMode) private var presentation
  
  var user: UserDomainModel?
  
  @State var profileImageData: Data = Data()
  @State var name: String = ""
  @State var email: String = ""
  @State var phoneNumber: String = ""
  @State var website: String = ""
  @State var githubUrl: String = ""
  
  @ObservedObject var editProfilePresenter: UserEditPresenter<Interactor<UserDomainModel, UserDomainModel, UpdateUserRepository<GetUserLocaleDataSource, UserTransformer>>>
  
  @State var isShowProfilePickerSheet = false
  @State var isGalleryPicker = false
  @State var isCameraPicker = false
  @State var isShowEditProfilePictureActionSheet = false
  
  var body: some View {
    NavigationView {
      
      VStack {
        HStack {
          Button(action: {
            self.isShowEditProfilePictureActionSheet = true
          }, label: {
            if !profileImageData.isEmpty {
              let decoded = (try? PropertyListDecoder().decode(Data.self, from: profileImageData)) ?? Data()
              
              Image(uiImage: UIImage(data: decoded)!)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .overlay(
                  Rectangle()
                    .opacity(0.6)
                  
                    .overlay(
                      Text(LocalizedLang.edit.uppercased())
                        .foregroundColor(Color.white)
                        .font(.caption)
                        .bold()
                        .padding(.top, -5)
                    )
                    .padding(.top, 70)
                )
                .clipShape(Circle())
            } else {
              defaultUserPhotoContent
            }
          })
        }
        
        .actionSheet(isPresented: $isShowEditProfilePictureActionSheet) {
          ActionSheet(
            title: Text(LocalizedLang.chooseMedia),
            buttons: [
              .cancel(),
              .default(Text(LocalizedLang.takePhoto)) {
                self.isShowProfilePickerSheet = true
                self.isCameraPicker = true
                self.isGalleryPicker = false
              },
              .default(Text(LocalizedLang.chooseMedia)) {
                self.isShowProfilePickerSheet = true
                self.isGalleryPicker = true
                self.isCameraPicker = false
              }
            ]
          )
        }
        .padding(.top, 30)
        
        formUserDataContent
      }
      .background(Color.init(.systemGray6))
      
      .navigationTitle(LocalizedLang.editProfile)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar(content: {
        
        ToolbarItem(placement: .navigationBarLeading, content: {
          Button(action: {
            self.presentation.wrappedValue.dismiss()
          }, label: {
            Text(LocalizedLang.cancel)
          })
        })
        
        ToolbarItem(placement: .navigationBarTrailing, content: {
          Button(action: {
            self.updateUserData()

            self.presentation.wrappedValue.dismiss()
          }, label: {
            Text(LocalizedLang.done)
          })
        })
        
      })
    }
    .onAppear {
      
      /// fill state variable with data)
      self.fillUserDataState()
    }
    .sheet(isPresented: $isShowProfilePickerSheet, onDismiss: {
    }) {
      if isCameraPicker {
        ImagePicker(sourceType: .camera, selectedImageData: self.$profileImageData)
      } else {
        ImagePicker(sourceType: .photoLibrary, selectedImageData: self.$profileImageData)
      }
      
    }
    
  }
}

extension EditProfileView {

  private var defaultUserPhotoContent: some View {
    Image("my-profile")
      .resizable()
      .scaledToFill()
      .frame(width: 100, height: 100)
      .overlay(
        Rectangle()
          .opacity(0.6)

          .overlay(
            Text(LocalizedLang.edit.uppercased())
              .foregroundColor(Color.white)
              .font(.caption)
              .bold()
              .padding(.top, -5)
          )
          .padding(.top, 70)
      )
      .clipShape(Circle())
  }

  private var formUserDataContent: some View {
    List {
      Section(header: Text(LocalizedLang.profileDetail), content: {
        TextField("Fullname", text: Binding<String>(get: {
          self.name
        }, set: {
          self.name = $0
        }))
        TextField("Email", text: Binding<String>(get: {
          self.email
        }, set: {
          self.email = $0
        }))
        TextField("No HP", text: Binding<String>(get: {
          self.phoneNumber
        }, set: {
          self.phoneNumber = $0
        }))
          .textContentType(.oneTimeCode)
          .keyboardType(.numberPad)
        TextField("Website", text: Binding<String>(get: {
          self.website
        }, set: {
          self.website = $0
        }))
      })

      Section(header: Text(LocalizedLang.devloperOnly), content: {
        TextField("GitHub Link", text: Binding<String>(get: {
          self.githubUrl
        }, set: {
          self.githubUrl = $0
        }))

      })
    }
    .padding(.top, 15)
    .listStyle(GroupedListStyle())
  }

  private func updateUserData() {
    self.editProfilePresenter.updateUser(request: UserDomainModel(id: "0", name: self.name, email: self.email, phoneNumber: self.phoneNumber, website: self.website, githubUrl: self.githubUrl, profilePicture: self.profileImageData))
  }

  private func fillUserDataState() {
    self.name = user?.name ?? ""
    self.email = user?.email ?? ""
    self.phoneNumber = user?.phoneNumber ?? ""
    self.website = user?.website ?? ""
    self.githubUrl = user?.githubUrl ?? ""
    self.profileImageData = user?.profilePicture ?? Data()
  }
}
