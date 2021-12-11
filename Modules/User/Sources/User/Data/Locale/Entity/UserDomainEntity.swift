//
//  File.swift
//
//
//  Created by Dimas Putro on 05/12/21.
//

import Foundation
import RealmSwift

public class UserDomainEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var email: String = ""
  @objc dynamic var phoneNumber: String = ""
  @objc dynamic var website: String = ""
  @objc dynamic var githubUrl: String = ""
  @objc dynamic var profilePicture: Data = Data()

  public override static func primaryKey() -> String? {
    return "id"
  }
}
