//
//  File.swift
//  
//
//  Created by Dimas Putro on 08/12/21.
//

import SwiftUI
import RxSwift

public class GetDetailPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {

  private let disposeBag = DisposeBag()

  private let _useCase: Interactor

  @Published public var detail: Response?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(useCase: Interactor) {
    _useCase = useCase
  }

  public func getDetail(request: Request?) {
    isLoading = true
    _useCase.execute(request: request)
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
