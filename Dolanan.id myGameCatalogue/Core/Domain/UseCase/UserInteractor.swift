//
//  UserInteractor.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import Foundation
import RxSwift

protocol UserUseCase {
  func addUser(data: UserModel) -> Observable<Bool>
  func getUser() -> Observable<UserModel>
}

class UserInteractor: UserUseCase {

  private let repository: UserRepositoryProtocol

  required init(repository: UserRepositoryProtocol) {
      self.repository = repository
  }

  func getUser() -> Observable<UserModel> {
    return repository.getUser()
  }

  func addUser(data: UserModel) -> Observable<Bool> {
    return repository.addUser(data: data)
  }
}
