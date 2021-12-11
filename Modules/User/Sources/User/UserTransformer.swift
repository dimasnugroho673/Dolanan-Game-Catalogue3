//
//  File.swift
//  
//
//  Created by Dimas Putro on 10/12/21.
//

import Foundation
import Core

public struct UserTransformer: UserMapper {
  public typealias Domain = UserDomainModel
  public typealias Entity = UserDomainEntity

  public init() {}
  
  public func transformUserDomainToEntity(userDomain: UserDomainModel) -> UserDomainEntity {
    let newUser = UserDomainEntity()
    newUser.id = userDomain.id ?? ""
    newUser.name = userDomain.name ?? ""
    newUser.email = userDomain.email ?? ""
    newUser.phoneNumber = userDomain.phoneNumber ?? ""
    newUser.website = userDomain.website ?? ""
    newUser.githubUrl = userDomain.githubUrl ?? ""
    newUser.profilePicture = userDomain.profilePicture ?? Data()

    return newUser
  }

  public func transformUserEntityToDomain(userEntity: UserDomainEntity) -> UserDomainModel {
    return UserDomainModel(id: userEntity.id, name: userEntity.name, email: userEntity.email, phoneNumber: userEntity.phoneNumber, website: userEntity.website, githubUrl: userEntity.githubUrl, profilePicture: userEntity.profilePicture)
  }
}
