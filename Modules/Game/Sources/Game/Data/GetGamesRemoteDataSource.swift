//
//  File.swift
//  
//
//  Created by Dimas Putro on 05/12/21.
//

import Core
import RxSwift
import Alamofire
import Foundation

public struct GetGamesRemoteDataSource: DataSource {
  public typealias Request = String
  public typealias Response = [GameResponse]
  
  private let _endpoint: String
  private let _apiKey: String
  
  public init(endpoint: String, apiKey: String) {
    _endpoint = endpoint
    _apiKey = apiKey
  }
  
  public func execute(request: String?) -> Observable<[GameResponse]> {
    if request != "" {
      let keywordToURL = request?.replacingOccurrences(of: " ", with: "+") ?? ""
      return Observable<[GameResponse]>.create { observer in
        if let url = URL(string: "\(_endpoint)?search=\(keywordToURL)&key=\(_apiKey)&page=1") {
          AF.request(url)
            .validate()
            .responseDecodable(of: GamesReponse.self) { reponse in
              switch reponse.result {
              case .success(let data):
                observer.onNext(data.games)
                observer.onCompleted()
              case .failure(let error):
                print("ERROR FOUND LIST GAME : \n\(String(describing: error.errorDescription))")
                observer.onError(URLError.invalidResponse)
              }
            }
        }
        return Disposables.create()
      }
    } else {
      return Observable<[GameResponse]>.create { observer in
        if let url = URL(string: "\(_endpoint)?key=\(_apiKey)") {
          AF.request(url)
            .validate()
            .responseDecodable(of: GamesReponse.self) { reponse in
              switch reponse.result {
              case .success(let data):
                observer.onNext(data.games)
                observer.onCompleted()
              case .failure(let error):
                print("ERROR FOUND SEARCH GAME : \n\(String(describing: error.errorDescription))")
                observer.onError(URLError.invalidResponse)
              }
            }
        }
        return Disposables.create()
      }
    }
  }
}
