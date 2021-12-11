//
//  File.swift
//  
//
//  Created by Dimas Putro on 29/11/21.
//

import RxSwift

public protocol Repository {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> Observable<Response>
}
