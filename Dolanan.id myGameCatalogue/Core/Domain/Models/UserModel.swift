//
//  UserModel.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import Foundation

struct UserModel: Codable {
  let id: String?
  var name: String?
  let email: String?
  let phoneNumber: String?
  let website: String?
  let githubUrl: String?
  let profilePicture: Data?
}
