//
//  LoadingState.swift
//  Dolanan.id myGame Catalogue
//
//  Created by Dimas Putro on 20/11/21.
//

import SwiftUI

/// loading indicator
struct LoadingState: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<LoadingState>) -> UIActivityIndicatorView {
    let indi = UIActivityIndicatorView(style: .medium)
    indi.color = UIColor.gray
    return indi
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingState>) {
    uiView.startAnimating()
  }
}
