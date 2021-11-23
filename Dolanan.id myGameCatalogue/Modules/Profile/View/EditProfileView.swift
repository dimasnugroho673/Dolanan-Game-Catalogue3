//
//  EditProfileView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import SwiftUI

struct EditProfileView: View {

  @Environment(\.presentationMode) private var presentation

  var user: UserModel?

  @State var profileImageData: Data = Data()
  @State var name: String = ""
  @State var email: String = ""
  @State var phoneNumber: String = ""
  @State var website: String = ""
  @State var githubUrl: String = ""

  @ObservedObject var editProfilePresenter: EditProfilePresenter

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
                      Text("EDIT")
                        .foregroundColor(Color.white)
                        .font(.caption)
                        .bold()
                        .padding(.top, -5)
                    )
                    .padding(.top, 70)
                )
                .clipShape(Circle())
            } else {
              Image("my-profile")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .overlay(
                  Rectangle()
                    .opacity(0.6)

                    .overlay(
                      Text("EDIT")
                        .foregroundColor(Color.white)
                        .font(.caption)
                        .bold()
                        .padding(.top, -5)
                    )
                    .padding(.top, 70)
                )
                .clipShape(Circle())
            }
          })
        }

        .actionSheet(isPresented: $isShowEditProfilePictureActionSheet) {
          ActionSheet(
            title: Text(""),
            buttons: [
              .cancel(),
              .default(Text("Take Photo")) {
                self.isShowProfilePickerSheet = true
                self.isCameraPicker = true
                self.isGalleryPicker = false
              },
              .default(Text("Choose Photo")) {
                self.isShowProfilePickerSheet = true
                self.isGalleryPicker = true
                self.isCameraPicker = false
              }
            ]
          )
        }
        .padding(.top, 30)

        List {
          Section(header: Text("Profile Detail"), content: {
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

          Section(header: Text("Developer Only"), content: {
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
      .background(Color.init(.systemGray6))

      .navigationTitle("Edit profile")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar(content: {

        ToolbarItem(placement: .navigationBarLeading, content: {
          Button(action: {
            self.presentation.wrappedValue.dismiss()
          }, label: {
            Text("Cancel")
          })
        })

        ToolbarItem(placement: .navigationBarTrailing, content: {
          Button(action: {
            //            self.userData.addItem(data: UserDataModel(name: self.fullname, email: self.email, phoneNumber: self.noHP, website: self.website, githubUrl: self.githubLink, profilePicture: self.profileImageData))

            self.editProfilePresenter.updateUser(data: UserModel(id: "0", name: self.name, email: self.email, phoneNumber: self.phoneNumber, website: self.website, githubUrl: self.githubUrl, profilePicture: self.profileImageData))

            if self.editProfilePresenter.updateUserStatus {
              self.presentation.wrappedValue.dismiss()
            }
          }, label: {
            Text("Done")
          })
        })

      })
    }
    .onAppear {

      /// fill state variable with data from environtment object after fetchItem()
      self.name = user?.name ?? ""
      self.email = user?.email ?? ""
      self.phoneNumber = user?.phoneNumber ?? ""
      self.website = user?.website ?? ""
      self.githubUrl = user?.githubUrl ?? ""
      self.profileImageData = user?.profilePicture ?? Data()
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

//struct EditProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    EditProfileView()
//  }
//}
