//
//  File.swift
//  
//
//  Created by Dimas Putro on 05/12/21.
//

import Core
import RxSwift

public struct GetGamesRepository<
  LocaleDataSource: GameLocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: GameMapper>: Repository
where
LocaleDataSource.Response == GameDomainEntity,
RemoteDataSource.Response == [GameResponse],
Transformer.Responses == [GameResponse],
Transformer.Entities == [GameDomainEntity],
Transformer.Domains == [GameDomainModel] {
  
  public typealias Request = String
  public typealias Response = [GameDomainModel]
  
  private let _localeDataSource: LocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: LocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
      
      _localeDataSource = localeDataSource
      _remoteDataSource = remoteDataSource
      _mapper = mapper
    }
  
  public func execute(request: String?) -> Observable<[GameDomainModel]> {
    return _remoteDataSource.execute(request: request as? RemoteDataSource.Request)
      .map { _mapper.transformGamesResponseToDomains(responses: $0) }
  }
  
}
