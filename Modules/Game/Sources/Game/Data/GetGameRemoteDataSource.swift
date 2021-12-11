//
//  File.swift
//  
//
//  Created by Dimas Putro on 07/12/21.
//

import Core
import RxSwift
import Alamofire
import Foundation

public struct GetGameRemoteDataSource: DataSource {
  public typealias Request = Int
  public typealias Response = GameDetailResponse

  private let _endpoint: String
  private let _apiKey: String

  public init(endpoint: String, apiKey: String) {
    _endpoint = endpoint
    _apiKey = apiKey
  }

  public func execute(request: Int?) -> Observable<GameDetailResponse> {
    return Observable<GameDetailResponse>.create { observer in
      if let url = URL(string: "\(_endpoint)/\(request ?? 0)?key=\(_apiKey)") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameDetailResponse.self) { reponse in
            switch reponse.result {
            case .success(let data):
              observer.onNext(data)
              observer.onCompleted()
            case .failure(let error):
              print("ERROR FOUND DETAIL GAME: \n\(String(describing: error.errorDescription))")
              observer.onError(URLError.invalidResponse)
            }
          }
      }
      return Disposables.create()
    }
  }
}
