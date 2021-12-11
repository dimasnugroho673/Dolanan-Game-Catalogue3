//
//  File.swift
//  
//
//  Created by Dimas Putro on 10/12/21.
//

import Foundation

public struct UserDomainModel: Codable {
  public var id: String?
  public var name: String?
  public var email: String?
  public var phoneNumber: String?
  public var website: String?
  public var githubUrl: String?
  public var profilePicture: Data?

  public init(id: String, name: String, email: String, phoneNumber: String, website: String, githubUrl: String, profilePicture: Data) {
    self.id = id
    self.name = name
    self.email = email
    self.phoneNumber = phoneNumber
    self.website = website
    self.githubUrl = githubUrl
    self.profilePicture = profilePicture
  }
}
