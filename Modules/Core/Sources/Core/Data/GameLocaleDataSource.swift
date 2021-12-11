//
//  File.swift
//  
//
//  Created by Dimas Putro on 29/11/21.
//

import RxSwift

public protocol GameLocaleDataSource {
  associatedtype Request
  associatedtype Response
  associatedtype Responses

  func getFavoriteGames() -> Observable<[Responses]>
  func getFavoriteGame(id: Int) -> Observable<Bool>
  func addGameToFavorite(entity: Request) -> Observable<Bool>
  func removeGameFromFavorite(id: Int) -> Observable<Bool>
}
