//
//  File.swift
//  
//
//  Created by Dimas Putro on 29/11/21.
//

import SwiftUI
import RxSwift

public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
  
  private let disposeBag = DisposeBag()
  
  private let _useCase: Interactor
  
  @Published public var list: [Response] = []
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  @Published public var keywordCounter: String = ""
  
  public init(useCase: Interactor) {
    _useCase = useCase
  }
  
  public func getList(request: Request?) {
    isLoading = true
    _useCase.execute(request: request ?? "" as! Request)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.list = result
      } onError: { error in
        print(String(describing: error.localizedDescription))
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
        self.isLoading = false
      }.disposed(by: disposeBag)
  }
}
