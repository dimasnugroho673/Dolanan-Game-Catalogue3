//
//  ProfilePresenter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import Foundation
import RxSwift
import SwiftUI

class ProfilePresenter: ObservableObject {
  
  private let userUseCase: UserUseCase
  
  @Published var user: UserModel?
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  
  private let disposeBag = DisposeBag()
  
  init(userUseCase: UserUseCase) {
    self.userUseCase = userUseCase
  }
  
  func getUser() {
    userUseCase.getUser()
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.user = result
      } onError: { error in
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
      }.disposed(by: disposeBag)
  }
}
