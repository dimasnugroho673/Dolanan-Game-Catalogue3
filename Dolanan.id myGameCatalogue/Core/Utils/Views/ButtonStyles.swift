//
//  ButtonStyles.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import SwiftUI

struct AddBookmarkButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .font(.headline)
      .frame(maxWidth: .infinity, minHeight: 45, alignment: .center)
      .contentShape(Rectangle())
      .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
      .listRowBackground(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
      .background(Color.accentColor)
      .cornerRadius(10)
  }
}

struct RemoveBookmarkButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .font(.headline)
      .frame(maxWidth: .infinity, minHeight: 45, alignment: .center)
      .contentShape(Rectangle())
      .foregroundColor(configuration.isPressed ? Color.accentColor.opacity(0.5) : Color.accentColor)
      .listRowBackground(configuration.isPressed ? Color.accentColor.opacity(0.5) : Color.accentColor)
      .background(Color.init(.systemGray6))
      .cornerRadius(10)
  }
}
