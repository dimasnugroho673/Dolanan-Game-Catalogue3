//
//  File.swift
//  
//
//  Created by Dimas Putro on 07/12/21.
//

import Core
import RxSwift

public struct GetGameRepository<
  LocaleDataSource: GameLocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: GameMapper>: Repository
where
LocaleDataSource.Response == GameDomainEntity,
RemoteDataSource.Response == GameDetailResponse,
Transformer.DetailResponse == GameDetailResponse,
Transformer.DetailDomain == GameDetailDomainModel {
  
  public typealias Request = Int
  public typealias Response = GameDetailDomainModel
  
  private let _localDataSource: LocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  
  public init(
    localDataSource: LocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
      _localDataSource = localDataSource
      _remoteDataSource = remoteDataSource
      _mapper = mapper
    }
  
  public func execute(request: Int?) -> Observable<GameDetailDomainModel> {
    return _remoteDataSource.execute(request: request as? RemoteDataSource.Request)
      .map { _mapper.transformGameDetailResponseToDomain(gameDetailResponse: $0) }
  }
  
}
