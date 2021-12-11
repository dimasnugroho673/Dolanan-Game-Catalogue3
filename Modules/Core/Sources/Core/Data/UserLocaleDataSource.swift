//
//  File.swift
//  
//
//  Created by Dimas Putro on 05/12/21.
//

import RxSwift

public protocol UserLocaleDataSource {
  associatedtype Request
  associatedtype Response

  func addUser(data: Response) -> Observable<Response>
  func getUser() -> Observable<Response>
}
