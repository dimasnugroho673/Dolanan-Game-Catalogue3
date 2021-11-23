//
//  UserMapper.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import Foundation

final class UserMapper {

  static func mapUserModelToEntities(
    input userModel: UserModel
  ) -> UserEntity {
    let newUser = UserEntity()
    newUser.id = userModel.id ?? ""
    newUser.name = userModel.name ?? ""
    newUser.email = userModel.email ?? ""
    newUser.phoneNumber = userModel.phoneNumber ?? ""
    newUser.website = userModel.website ?? ""
    newUser.githubUrl = userModel.githubUrl ?? ""
    newUser.profilePicture = userModel.profilePicture ?? Data()

    return newUser
  }

  static func mapUserEntitiesToDomains(
    input userEntity: UserEntity
  ) -> UserModel {
    return UserModel(id: userEntity.id, name: userEntity.name, email: userEntity.email, phoneNumber: userEntity.phoneNumber, website: userEntity.website, githubUrl: userEntity.githubUrl, profilePicture: userEntity.profilePicture)
  }

}
