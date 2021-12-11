//
//  File.swift
//
//
//  Created by Dimas Putro on 05/12/21.
//

import Foundation
import Core
import RealmSwift
import RxSwift

public struct GetUserLocaleDataSource: UserLocaleDataSource {

  public typealias Request = UserDomainEntity
  public typealias Response = UserDomainEntity

  private let _realm: Realm?

  public init(realm: Realm) {
    _realm = realm
  }

  public func addUser(data: UserDomainEntity) -> Observable<UserDomainEntity> {
    return Observable<UserDomainEntity>.create { observer in
      if let localDatabase = self._realm {
        do {

          let user = localDatabase.objects(UserDomainEntity.self).filter("id == %@", "0").first

          if let user = user {
            try localDatabase.write {
              user.name = data.name
              user.email = data.email
              user.phoneNumber = data.phoneNumber
              user.website = data.website
              user.githubUrl = data.githubUrl
              user.profilePicture = data.profilePicture

              observer.onNext(user)
              observer.onCompleted()
              print("user has been updated")
            }
          } else {
            try localDatabase.write {
              localDatabase.add(data)

              observer.onNext(data)
              observer.onCompleted()
              print("data has been saved to local DB")
            }
          }
        } catch {
          observer.onError(DatabaseError.requestFailed)
          print(DatabaseError.requestFailed)
        }
      } else {
        observer.onError(DatabaseError.requestFailed)
        print(DatabaseError.requestFailed)
      }
      return Disposables.create()
    }
  }

  public func getUser() -> Observable<UserDomainEntity> {
    return Observable<UserDomainEntity>.create { observer in
      if let localDatabase = self._realm {
        let getObjectById = localDatabase.objects(UserDomainEntity.self).filter("id == %@", "0").first

        observer.onNext(getObjectById!)
        observer.onCompleted()
      } else {
        observer.onError(DatabaseError.requestFailed)
        print(DatabaseError.requestFailed)
      }
      return Disposables.create()
    }
  }

}
