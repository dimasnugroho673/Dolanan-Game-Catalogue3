//
//  DetailGamePresenter.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import Foundation
import RxSwift

class DetailGamePresenter: ObservableObject {

  private let detailGameUseCase: DetailGameUseCase

  @Published var gameDetail: GameDetailModel?
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true

  private let disposeBag = DisposeBag()

  init(detailGameUseCase: DetailGameUseCase) {
    self.detailGameUseCase = detailGameUseCase
  }

  func getGameDetail(id: Int) {
    isLoading = true
    detailGameUseCase.getGameDetail(id: id)
      .observe(on: MainScheduler.instance)
      .subscribe { result in
        self.gameDetail = result
      } onError: { error in
        self.errorMessage = String(describing: error.localizedDescription)
      } onCompleted: {
        self.isLoading = false
      }.disposed(by: disposeBag)
  }

}
