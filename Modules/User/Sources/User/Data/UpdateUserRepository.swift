//
//  File.swift
//  
//
//  Created by Dimas Putro on 10/12/21.
//

import RxSwift
import Core

public struct UpdateUserRepository<
  LocaleDataSource: UserLocaleDataSource,
  Transformer: UserMapper>: Repository
where
LocaleDataSource.Response == UserDomainEntity,
Transformer.Entity == UserDomainEntity,
Transformer.Domain == UserDomainModel {
  
  public typealias Request = UserDomainModel
  public typealias Response = UserDomainModel
  
  private let _localDataSource: LocaleDataSource
  private let _mapper: Transformer
  
  public init(
    localDataSource: LocaleDataSource,
    mapper: Transformer) {
      _localDataSource = localDataSource
      _mapper = mapper
    }
  
  public func execute(request: UserDomainModel?) -> Observable<UserDomainModel> {
    return _localDataSource.addUser(data: _mapper.transformUserDomainToEntity(userDomain: request!) )
      .map { _mapper.transformUserEntityToDomain(userEntity: $0) }
  }
  
}
