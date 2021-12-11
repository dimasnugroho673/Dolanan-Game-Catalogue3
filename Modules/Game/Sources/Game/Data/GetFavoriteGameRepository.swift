//
//  File.swift
//  
//
//  Created by Dimas Putro on 08/12/21.
//

import RxSwift
import Core

public struct GetFavoriteGameRepository<
  LocaleDataSource: GameLocaleDataSource,
  Transformer: GameMapper>: Repository
where
LocaleDataSource.Response == GameDomainEntity,
Transformer.Responses == [GameResponse],
Transformer.Entities == [GameDomainEntity],
Transformer.Domains == [GameDomainModel] {

  public typealias Request = Any
  public typealias Response = [GameDomainModel]

  private let _localDataSource: LocaleDataSource
  private let _mapper: Transformer

  public init(
    localDataSource: LocaleDataSource,
    mapper: Transformer) {
      _localDataSource = localDataSource
      _mapper = mapper
    }

  public func execute(request: Any?) -> Observable<[GameDomainModel]> {
    return _localDataSource.getFavoriteGames()
      .map { _mapper.transformGameEntitiesToDomains(gameEntities: $0 as! Transformer.Entities) }
  }

}
