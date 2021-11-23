//
//  UserRepository.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import Foundation
import RxSwift

protocol UserRepositoryProtocol {
  func addUser(data: UserModel) -> Observable<Bool>
  func getUser() -> Observable<UserModel>
//  func updateUser(data: UserEntity) -> Observable<Bool>
}

final class UserRepository: NSObject {
  typealias UserInstance = (LocalDataSource) -> UserRepository

  fileprivate let local: LocalDataSource

  private init(local: LocalDataSource) {
    self.local = local
  }

  static let sharedInstance: UserInstance = { localRepository in
    return UserRepository(local: localRepository)
  }
}

extension UserRepository: UserRepositoryProtocol {

  func addUser(data: UserModel) -> Observable<Bool> {
    return self.local.addUser( data: UserMapper.mapUserModelToEntities(input: data) )
  }

  func getUser() -> Observable<UserModel> {
    return self.local.getUser()
      .map { UserMapper.mapUserEntitiesToDomains(input: $0) }
  }

}
