//
//  File.swift
//  
//
//  Created by Dimas Putro on 30/11/21.
//

import Foundation

public protocol GameMapper {
  associatedtype Request
  associatedtype Requests
  associatedtype Response
  associatedtype DetailResponse
  associatedtype Responses

  associatedtype Entity
  associatedtype Entities
  associatedtype Domain
  associatedtype DetailDomain
  associatedtype Domains

  func transformGamesResponseToDomains(responses: Responses) -> Domains
  func transformGameDetailResponseToDomain(gameDetailResponse: DetailResponse) -> DetailDomain
  func transformGameDomainToEntity(gameDomain: Domain) -> Entity
  func transformGameEntitiesToDomains(gameEntities: Entities) -> Domains
}
