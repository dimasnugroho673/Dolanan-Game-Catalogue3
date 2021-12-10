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

struct LoadingIndicator: View {
  var body: some View {
    HStack(alignment: .center) {
      Spacer()
      VStack {
        Spacer()
        LoadingState().padding(.top, 10)
        Text("LOADING").font(.caption).foregroundColor(.gray).padding(.top, 5)
        Spacer()
      }
      Spacer()
    }.frame(width: .infinity, height: UIScreen.main.bounds.height / 2, alignment: .center)
  }
}
