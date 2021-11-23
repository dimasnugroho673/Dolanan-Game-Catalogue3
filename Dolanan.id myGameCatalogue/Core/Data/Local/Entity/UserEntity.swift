//
//  UserEntity.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import Foundation
import RealmSwift

class UserEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var email: String = ""
  @objc dynamic var phoneNumber: String = ""
  @objc dynamic var website: String = ""
  @objc dynamic var githubUrl: String = ""
  @objc dynamic var profilePicture: Data = Data()

  override static func primaryKey() -> String? {
    return "id"
  }
}
