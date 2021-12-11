//
//  File.swift
//  
//
//  Created by Dimas Putro on 10/12/21.
//

import RxSwift
import Core

public struct GetUserRepository<
  LocaleDataSource: UserLocaleDataSource,
  Transformer: UserMapper>: Repository
where
LocaleDataSource.Response == UserDomainEntity,
Transformer.Entity == UserDomainEntity,
Transformer.Domain == UserDomainModel {
  
  public typealias Request = Any
  public typealias Response = UserDomainModel
  
  private let _localDataSource: LocaleDataSource
  private let _mapper: Transformer
  
  public init(
    localDataSource: LocaleDataSource,
    mapper: Transformer) {
      _localDataSource = localDataSource
      _mapper = mapper
    }
  
  public func execute(request: Any?) -> Observable<UserDomainModel> {
    return _localDataSource.getUser()
      .map { _mapper.transformUserEntityToDomain(userEntity: $0) }
  }
}
