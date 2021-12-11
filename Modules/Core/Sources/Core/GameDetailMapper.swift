//
//  File.swift
//  
//
//  Created by Dimas Putro on 07/12/21.
//

public protocol GameDetailMapper {
  associatedtype Request
  associatedtype Response
  associatedtype Domain
  associatedtype Entity

  func transformResponseToDomain(request: Request?, response: Response) -> Domain
  func transformDomainToEntity(request: Domain) -> Entity
}
