//
//  File.swift
//  
//
//  Created by Dimas Putro on 10/12/21.
//

import SwiftUI
import RxSwift
import Core

public class UserDetailPresenter<UserUseCase: UseCase>: ObservableObject
where
UserUseCase.Request == UserDomainModel, UserUseCase.Response == UserDomainModel {

  private let disposeBag = DisposeBag()

  private let _userUseCase: UserUseCase

  @Published public var detail: UserDomainModel?
  @Published public var favoriteGames: [Int] = [0]
  @Published public var isFavorite: Bool = false
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(userUseCase: UserUseCase) {
    _userUseCase = userUseCase
  }

  public func getDetail(request: UserUseCase.Request) {
    isLoading = true
    _userUseCase.execute(request: request)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.detail = result
      } onError: { error in
        print(String(describing: error.localizedDescription))
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
        self.isLoading = false
      }.disposed(by: disposeBag)
  }
}
