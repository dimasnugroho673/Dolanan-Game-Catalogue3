//
//  OnboardingPresenter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import Foundation
import RxSwift
import SwiftUI

class OnboardingPresenter: ObservableObject {

  private let userUseCase: UserUseCase

  @Published var images: [String] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true
  @Published var createUserStatus: Bool = false

  private let disposeBag = DisposeBag()

  init(userUseCase: UserUseCase) {
    self.userUseCase = userUseCase
    self.images = ["onboarding", "onboarding2", "onboarding3"]
  }

  func createUser(data: UserModel) {
    userUseCase.addUser(data: data)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.createUserStatus = result
      } onError: { error in
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {

      }.disposed(by: disposeBag)
  }

}
