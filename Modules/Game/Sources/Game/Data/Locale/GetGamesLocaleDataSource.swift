//
//  File.swift
//  
//
//  Created by Dimas Putro on 05/12/21.
//

import Core
import RealmSwift
import RxSwift

public struct GetGamesLocaleDataSource: GameLocaleDataSource {
  public typealias Request = GameDomainModel
  public typealias Response = GameDomainEntity

  private let _realm: Realm?
  private let _mapper = GameTransformer()

  public init(realm: Realm) {
    _realm = realm
  }

  public func getFavoriteGames() -> Observable<[GameDomainEntity]> {
    return Observable<[GameDomainEntity]>.create { observer in
      if let localDatabase = self._realm {
        let favoriteGames: Results<GameDomainEntity> = {
          localDatabase.objects(GameDomainEntity.self)
            .sorted(byKeyPath: "id", ascending: false)
        }()
        observer.onNext(favoriteGames.toArray(ofType: GameDomainEntity.self))
        observer.onCompleted()
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }

  public func getFavoriteGame(id: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      if let localDatabase = self._realm {
        do {
          let getObjectById = localDatabase.objects(GameDomainEntity.self).filter("id == %@", id).first

          if getObjectById != nil {
            observer.onNext(true)
          } else {
            observer.onNext(false)
          }

          observer.onCompleted()
        }
      } else {
        observer.onError(DatabaseError.requestFailed)
        print(DatabaseError.requestFailed)
      }
      return Disposables.create()
    }
  }

  public func addGameToFavorite(entity: GameDomainModel) -> Observable<Bool> {

    let convert = self._mapper.transformGameDomainToEntity(gameDomain: entity)

    return Observable<Bool>.create { observer in
      if let localDatabase = self._realm {
        do {
          let getObjectById = localDatabase.objects(GameDomainEntity.self).filter("id == %@", convert.id).first

          if getObjectById != nil {
            try localDatabase.write {
              localDatabase.delete(getObjectById!)

              observer.onNext(true)
              observer.onCompleted()
              print("data has beeen deleted to local DB")
            }
          } else {
            try localDatabase.write {
              localDatabase.add(convert)

              observer.onNext(true)
              observer.onCompleted()
              print("data has beeen saved to local DB")
              print(convert)
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

  public func removeGameFromFavorite(id: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      if let localDatabase = self._realm {
        do {

          let getObjectById = localDatabase.objects(GameDomainEntity.self).filter("id == %@", id).first

          try localDatabase.write {
            localDatabase.delete(getObjectById!)

            observer.onNext(true)
            observer.onCompleted()
            print("data has beeen deleted to local DB")
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

}
