//
//  EditProfilePresenter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 22/11/21.
//

import Foundation
import RxSwift
import SwiftUI

class EditProfilePresenter: ObservableObject {
  
  private let userUseCase: UserUseCase
  
  @Published var user: UserModel?
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var updateUserStatus: Bool = false
  
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
  
  func updateUser(data: UserModel) {
    userUseCase.addUser(data: data)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.updateUserStatus = result
      } onError: { error in
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
        
      }.disposed(by: disposeBag)
  }
  
}
