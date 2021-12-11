//
//  File.swift
//  
//
//  Created by Dimas Putro on 08/12/21.
//

import RxSwift
import Core

public struct UpdateFavoriteGameRepository<
  LocaleDataSource: GameLocaleDataSource,
  Transformer: GameMapper>: Repository
where
LocaleDataSource.Request == GameDomainModel,
LocaleDataSource.Response == GameDomainEntity,
Transformer.Entity == GameDomainEntity,
Transformer.Domain == GameDomainModel {
  
  public typealias Request = GameDomainModel
  public typealias Response = Bool
  
  private let _localDataSource: LocaleDataSource
  private let _mapper: Transformer
  
  public init(
    localDataSource: LocaleDataSource,
    mapper: Transformer) {
      _localDataSource = localDataSource
      _mapper = mapper
    }
  
  public func execute(request: GameDomainModel?) -> Observable<Bool> {
    return _localDataSource.addGameToFavorite(entity: request!)
  }
}
