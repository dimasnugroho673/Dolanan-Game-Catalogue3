//
//  ProfileNavbar.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import SwiftUI

struct ProfilePictureNavbar: View {

  var profileImageData: Data = Data()

  var body: some View {
    VStack {
      if !profileImageData.isEmpty {
        let decoded = (try? PropertyListDecoder().decode(Data.self, from: profileImageData)) ??  Data()

        Image(uiImage: UIImage(data: decoded)!)
          .resizable()
          .renderingMode(.original)
          .frame(width: 37, height: 37)
          .clipShape(Circle())
      } else {
        Image("my-profile")
          .resizable()
          .renderingMode(.original)
          .frame(width: 37, height: 37)
          .clipShape(Circle())
      }
    }
  }
}
