//
//  RemoteDataSource.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
  func getPopularGames() -> Observable<[GameResponse]>
  func getDetailGame(id: Int) -> Observable<GameDetailResponse>
  func getGamesByKeyword(keyword: String) -> Observable<[GameResponse]>
}

final class RemoteDataSource: NSObject {
  private override init() { }

  static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getPopularGames() -> Observable<[GameResponse]> {
    return Observable<[GameResponse]>.create { observer in
      if let url = URL(string: "\(Constants.api)games?key=\(Constants.apiKey)&page=1") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesReponse.self) { reponse in
            switch reponse.result {
            case .success(let data):
              observer.onNext(data.games)
              observer.onCompleted()
            case .failure(let error):
              print("ERROR FOUND : \n\(String(describing: error.errorDescription))")
              observer.onError(URLError.invalidResponse)
            }
          }
      }
      return Disposables.create()
    }
  }

  func getDetailGame(id: Int) -> Observable<GameDetailResponse> {
    return Observable<GameDetailResponse>.create { observer in
      if let url = URL(string: "\(Constants.api)games/\(id)?key=\(Constants.apiKey)") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameDetailResponse.self) { reponse in
            switch reponse.result {
            case .success(let data):
              observer.onNext(data)
              observer.onCompleted()
            case .failure(let error):
              print("ERROR FOUND : \n\(String(describing: error.errorDescription))")
              observer.onError(URLError.invalidResponse)
            }
          }
      }
      return Disposables.create()
    }
  }

  func getGamesByKeyword(keyword: String) -> Observable<[GameResponse]> {

    let keywordToURL = keyword.replacingOccurrences(of: " ", with: "+")

    return Observable<[GameResponse]>.create { observer in
      if let url = URL(string: "\(Constants.api)games?search=\(keywordToURL)&key=\(Constants.apiKey)") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesReponse.self) { reponse in
            switch reponse.result {
            case .success(let data):
              observer.onNext(data.games)
              observer.onCompleted()
            case .failure(let error):
              print("ERROR FOUND : \n\(String(describing: error.errorDescription))")
              observer.onError(URLError.invalidResponse)
            }
          }
      }
      return Disposables.create()
    }
  }

}
